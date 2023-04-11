alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique | .[].id|=(split(\":\")|join(\" \"))' > $XDG_CACHE_HOME/fzf/sfdxcommands.json"

alias dxenv="jq \".target-org\" .sfdx/sfdx-config.json"

autoload -Uz dxd
autoload -Uz _dxd

dxalias() { 
  echo $(jq .defaultusername -r .sfdx/sfdx-config.json)
}

local dx_saveincref() {
  local head_commit=$(git rev-parse HEAD) 
  echo $head_commit > .sfdx/.lastincref
}

# commit ID
dxincbuild() {
  local incdir="${2:-deploy}"
  test -d "$incdir" && rm -r "$incdir" && mkdir -p "$incdir"
  sfdx sgd:source:delta --to "HEAD" --from "$1" --output "$incdir" --generate-delta
}

# Usage: dxinccheck <branch> <username/alias> <dir>
# branch = branch to generate delta against
# username = salesforce username
# dir = directory to save delta package into
# TODO: include destructive changes
# TODO: Accept named arguments using getopts
# TODO: Convert to bash from zsh
dxinccheck(){
  if (($# < 2)); then
    >&2 echo "Usage: dxinccheck <branch> <username/alias> <dir?=delta>"
    return 1
  fi
  # if [[ -z $1 ]]; then
  #   >&2 echo "No target branch for fork-point specified. Exiting..."
  #   return 1;
  # fi
  local fork_point=$(git merge-base "$1" HEAD)
  echo "fork_point = $fork_point"
  local user="${2:?Target username not provided}"
  local incdir="${3:-delta}"
  test -d "$incdir" && rm -r "$incdir"
  mkdir -p "$incdir"
  sfdx sgd:source:delta --to "HEAD" --from "$fork_point" --output "$incdir" --generate-delta
  sfdx force:source:deploy --checkonly -p "$incdir"/force-app -u "$user"
}

# Usage: dxincautodeploy <username> <commit_ish_override=.sfdx/.lastincref> <output_directory=delta>
# username = salesforce username or alias
# commit_id_override = commit-ishto use instead of the default, which is the value of .sfdx/.lastincref locally stored.
# output_directory = directory to store incremental package.
# TODO: Auto run destructive changes
# TODO: Detect and run vlocity deltas
# TODO: Accept named arguments using getopts
# TODO: Convert to bash from zsh
dxincautodeploy() {
  if [[ ! -f .sfdx/.lastincref ]]; then
    >&2 echo "No previous commit ref stored in .sfdx/.lastincref"
  fi
  last_commit="${2:-$(< .sfdx/.lastincref)}"
  if [[ -z $last_commit ]]; then
    echo "No commit id provided. Exiting..."
    return 1;
  fi
  local head_commit=$(git rev-parse HEAD) 
  if [[ $head_commit = $last_commit ]]; then
    echo "current HEAD matches previous autodeploy ref. Exiting..."
    return 1;
  fi
  echo "Previous commit hash $last_commit - starting delta build..."
  local user="${1:?Username or alias not specified.}"
  local incdir="${3:-delta}"
  sfdx sgd:source:delta --to "HEAD" --from "$last_commit" --output "$incdir" --generate-delta
  sfdx force:source:deploy -p "$incdir"/force-app -u "$user"
  echo $head_commit > .sfdx/.lastincref
  echo "$head_commit saved as last incremental commit ID"
}


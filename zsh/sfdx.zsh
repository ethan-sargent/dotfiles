alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > $XDG_CACHE_HOME/fzf/sfdxcommands.json"

alias dxenv="jq \".defaultusername\" .sfdx/sfdx-config.json"

dxd() { 
  if $(jq ".orgs | has(\"$1\")" ~/.sfdx/alias.json -e); then
    echo $(jq ".defaultusername = \"$1\""  .sfdx/sfdx-config.json) > .sfdx/sfdx-config.json;
  else
    echo "Alias $1 not found. Aliases:" 
    jq '.orgs | keys' ~/.sfdx/alias.json
  fi
}

dxalias() { 
  echo $(jq .defaultusername -r .sfdx/sfdx-config.json)
}

local dx_saveincref() {
  local head_commit=$(git rev-parse HEAD) 
  echo $head_commit > .sfdx/.lastincref
}

local dxautoinc() {
  local head_commit=$(git rev-parse HEAD) 
  echo $head_commit > .sfdx/.lastincref
  local branch_forkpoint=$(git merge-base --fork-point HEAD acfr-qfr/rolling)

  sfdx sfpowerkit:project:diff -d "$incdir" -r "$1" -x
}

# commit ID
dxincbuild() {
  local incdir="${2:-deploy}"
  test -d "$incdir" && rm -r "$incdir" && mkdir -p "$incdir"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$1" -x
}

# commit id, org to validate against, dir to package into (optional)
# dxinccheck a0d1ebe72
dxinccheck(){
  local fork_point=$(git merge-base acfr-qfr/rolling HEAD --fork-point)
  local commit_id="${1:-$fork_point}"
  local incdir="${3:-deploy}"
  local user="${2:-dit}"
  test -d "$incdir" && rm -r "$incdir" && mkdir -p "$incdir"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$commit_id" -x 
  sfdx force:source:deploy --checkonly -p "$incdir"/force-app -u "$user"
}

dxincautodeploy() {
  trap 'tput cnorm; exit' INT TERM
  if [[ ! -f .sfdx/.lastincref ]]; then
    >&2 echo "No previous commit ref stored in .sfdx/.lastincref"
  fi
  last_commit="${1:-$(< .sfdx/.lastincref)}"
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
  local incdir="${2:-deploy}"
  local user="${1:-dit}"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$last_commit" -x 
  sfdx force:source:deploy -p "$incdir"/force-app -u "$user"
  echo $head_commit > .sfdx/.lastincref
  echo "$head_commit saved as last incremental commit ID"
}


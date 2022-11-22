alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > $XDG_CACHE_HOME/fzf/sfdxcommands.json"

alias dxenv="cat .sf/config.json | yq .target-org"

dxd() { 
  sf config set target-org=$1 
}

# commit ID
dxinc() {
  test -d deploy && rm -r deploy
  local incdir="${1:-8000}"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$2" -x
}


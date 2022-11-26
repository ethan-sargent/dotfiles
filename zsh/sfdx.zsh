alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > $XDG_CACHE_HOME/fzf/sfdxcommands.json"

alias dxenv="cat .sfdx/sfdx-config.json | yq .defaultusername"

dxd() { 
  echo $(cat .sfdx/sfdx-config.json | jq ".\"defaultusername\" = \"$1\"") > .sfdx/sfdx-config.json
  cat .sfdx/sfdx-config.json | jq '."defaultusername"'
}

# commit ID
dxinc() {
  local incdir="${2:-deploy}"
  test -d "$incdir" && rm -r "$incdir" && mkdir -p "$incdir"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$1" -x
}


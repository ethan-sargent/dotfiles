alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > $XDG_CACHE_HOME/fzf/sfdxcommands.json"

alias dxenv="cat .sfdx/sfdx-config.json | yq .defaultusername"

dxd() { 
  echo $(cat .sfdx/sfdx-config.json | jq ".\"defaultusername\" = \"$1\"") > .sfdx/sfdx-config.json
  cat .sfdx/sfdx-config.json | jq '."defaultusername"'
}

# commit ID
dxinc() {
  test -d deploy && rm -r deploy
  local incdir="${1:-8000}"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$2" -x
}


alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > $XDG_CACHE_HOME/fzf/sfdxcommands.json"

alias dxenv="jq \".defaultusername\" .sfdx/sfdx-config.json"

dxd() { 
  if $(jq ".orgs | has(\"$1\")" ~/.sfdx/alias.json -e); then
    echo $(jq ".defaultusername = \"$1\""  .sfdx/sfdx-config.json) > .sfdx/sfdx-config.json;
  else
    echo "Alias $1 not found"
  fi
}

dxalias() { 
  echo $(jq .defaultusername -r .sfdx/sfdx-config.json)
}

# commit ID
dxinc() {
  local incdir="${2:-deploy}"
  test -d "$incdir" && rm -r "$incdir" && mkdir -p "$incdir"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$1" -x
}

# commit id, org to validate against, dir to package into (optional)
# dxinccheck a0d1ebe72
dxinccheck(){
  local incdir="${3:-deploy}"
  local user="${2:-dit}"
  test -d "$incdir" && rm -r "$incdir" && mkdir -p "$incdir"
  sfdx sfpowerkit:project:diff -d "$incdir" -r "$1" -x 
  sfdx force:source:deploy --checkonly -p "$incdir"/force-app -u "$user"
}

dxincdeploy(){
  local incdir="${2:-deploy}"
  local user="${1:-dit}"
  sfdx force:source:deploy -p "$incdir"/force-app -u "$user"
}



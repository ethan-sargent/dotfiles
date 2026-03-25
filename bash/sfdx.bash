#!/bin/bash
# Salesforce CLI shell functions for Git Bash
# Ported from zsh/sfdx.zsh and zsh/functions/dxd

# Fast org switching (equivalent of zsh dxd function)
dxd() {
  if [[ -z "$1" ]]; then
    echo "Usage: dxd <org-alias>" >&2
    return 1
  fi
  sfkit config set --target-org="$1"
}

# Show current default username from sfdx config
dxalias() {
  if [[ -f .sfdx/sfdx-config.json ]]; then
    node -e "
      const c = require('./.sfdx/sfdx-config.json');
      console.log(c['defaultusername'] || c['target-org'] || '');
    "
  else
    echo "No .sfdx/sfdx-config.json found" >&2
  fi
}

# Show current target org
dxenv() {
  if [[ -f .sfdx/sfdx-config.json ]]; then
    node -e "
      const c = require('./.sfdx/sfdx-config.json');
      console.log(c['target-org'] || '');
    "
  else
    echo "No .sfdx/sfdx-config.json found" >&2
  fi
}

# Refresh sfdx command cache for reference
sfdx-refresh-cache() {
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/sfdx"
  mkdir -p "$cache_dir"
  sf commands --json > "$cache_dir/sfcommands.json"
  echo "SF command cache refreshed at $cache_dir/sfcommands.json"
}

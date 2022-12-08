#!/bin/zsh
#
# on macos, 
source "$HOME/.cargo/env"

# XDG compat
export XDG_CONFIG_HOME="$HOME"/.config
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-~/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-~/.xdg}

# MacOS-specific 
if [[ "$OSTYPE" == darwin* ]]; then
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home
  export PATH=$JAVA_HOME/bin:$PATH
fi

if [[ -d "/opt/homebrew" ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
else
  export HOMEBREW_PREFIX=/usr/local
fi

# add bison into start of path if exists
brew --prefix bison &> /dev/null
if [ $? -eq 0 ]; then  
  export PATH="$(brew --prefix bison)/bin:$PATH"
fi

export PATH="/usr/local/sbin:$PATH"

# disables zsh sessions 
export SHELL_SESSIONS_DISABLE=1

# Volta - Version Manager for packages eg node
# unfortunately not XDG compliant yet - unsure where this should go

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


fpath=(
  $ZDOTDIR/functions
  $fpath
);

source "$ZDOTDIR/sfdx.zsh"


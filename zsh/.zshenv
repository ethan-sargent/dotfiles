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
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/graalvm-jdk-17.0.10+11.1/Contents/Home"
  export PATH="/Library/Java/JavaVirtualMachines/graalvm-jdk-17.0.10+11.1/Contents/Home/bin:$PATH"
  export PATH=$JAVA_HOME/bin:$PATH
fi

if [[ -d "/opt/homebrew" ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
else
  export HOMEBREW_PREFIX=/usr/local
fi

if [[ -d "/Applications/Visual Studio Code.app" ]]; then
  export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin":$PATH;
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

# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"
eval "$(/usr/local/bin/rtx activate zsh)"
export PATH="$HOME/.bun/bin/:$PATH"

export BUN_INSTALL=$XDG_STATE_HOME/bun
export BUN_HOME=$BUN_INSTALL/bun
export PATH="$BUN_INSTALL/bin:$PATH"
fpath=(
  $ZDOTDIR/functions
  $fpath
);

source "$ZDOTDIR/sfdx.zsh"
export SF_AUTOUPDATE_DISABLE=true

export JAVAFX_HOME="/usr/local/javafx-sdk-20.0.1"
export PATH_TO_FX="/usr/local/javafx-sdk-20.0.1/lib"
. "$HOME/.cargo/env"

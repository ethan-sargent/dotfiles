#!/bin/zsh
#
# on macos, 
. "$HOME/.cargo/env"

# on MacOS, set these in /etc/zshenv to source from ~/.config/zsh automatically
# export XDG_CONFIG_HOME="$HOME"/.config
# export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# XDG compat
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-~/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-~/.xdg}

# editor
export EDITOR="nvim"
export VISUAL="nvim"


# Node Compiler detection env vars

export LDFLAGS="-L/usr/local/opt/node@16/lib"
export CPPFLAGS="-I/usr/local/opt/node@16/include"

#!/bin/zsh
#
# Usage: Run when first pulling dotfiles to ensure configuration files are linked to the repo
#
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# ensure XDG_CONFIG_HOME is set
source $SCRIPT_DIR/zsh/.zshenv

# symlink zsh and nvim
ln -s -F "$SCRIPT_DIR"/zsh "$XDG_CONFIG_HOME"
ln -s -F "$SCRIPT_DIR"/nvim "$XDG_CONFIG_HOME"

# TODO: make tmux XDG compliant and symlink

# TODO: Copy alacritty config based on OS due to Mac config incompatiblities


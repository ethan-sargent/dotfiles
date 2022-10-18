#!/bin/zsh
#
# Usage: Run when first pulling dotfiles to ensure configuration files are linked to the repo
#
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
printf $SCRIPT_DIR
# ensure XDG_CONFIG_HOME is set
source $SCRIPT_DIR/zsh/.zshenv

# symlink zsh and nvim
ln -s "$SCRIPT_DIR"/zsh "$XDG_CONFIG_HOME"/zsh
ln -s "$SCRIPT_DIR"/nvim "$XDG_CONFIG_HOME"/nvim

# TODO: make tmux XDG compliant and symlink

# TODO: Copy alacritty config based on OS due to Mac config incompatiblities


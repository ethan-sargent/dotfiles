#!/bin/zsh
#
# Usage: Run when first pulling dotfiles to ensure configuration files are linked to the repo
#
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# ensure XDG_CONFIG_HOME is set
printf "ensuring XDG compliance\n"
source $SCRIPT_DIR/zsh/.zshenv

# printf "attempting to symlink configuration into XDG_CONFIG_HOME: $XDG_CONFIG_HOME\n"
# if [[ test -d "$XDG_CONFIG_HOME"/zsh ]] then
#   "XDG_CONFIG_HOME"/zsh "XDG_CONFIG_HOME"/zsh_backup
#   printf "saving old zsh configuration at $XDG_CONFIG_HOME/zsh_backup\n"
# fi
#
# if [[ test -d "$XDG_CONFIG_HOME"/nvim ]] then
#   mv "XDG_CONFIG_HOME"/nvim "XDG_CONFIG_HOME"/nvim_backup
#   printf "saving old nvim configuration at $XDG_CONFIG_HOME/nvim_backup\n"
# fi
# symlink zsh and nvim
ln -s "$SCRIPT_DIR"/zsh "$XDG_CONFIG_HOME"
ln -s "$SCRIPT_DIR"/nvim "$XDG_CONFIG_HOME"

# TODO: make tmux XDG compliant and symlink

# TODO: Copy alacritty config based on OS due to Mac config incompatiblities




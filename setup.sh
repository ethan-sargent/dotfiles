#!/bin/zsh
#
# Usage: Run when first pulling dotfiles to ensure configuration files are linked to the repo
#
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ -v $XDG_CONFIG_HOME ]]; then
  printf "no existing XDG_CONFIG_HOME, using $HOME/.config\n"
  XDG_CONFIG_HOME = "$HOME"/.config
else
  printf "XDG_CONFIG_HOME found! using $XDG_CONFIG_HOME\n"
fi

if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
  printf "no directory $XDG_CONFIG_HOME found, creating...\n"
  mkdir -p "$XDG_CONFIG_HOME"
fi

printf "linking minimal zshenv to $HOME/.zshenv\n"
if [[ ! -f "$HOME"/.zshenv ]] then 
  ln -s "$SCRIPT_DIR"/.zshenv "$HOME"/.zshenv
else
  printf "file found at $HOME/.zshenv, skipping...\n"
fi

printf "linking configuration now\n"
dirs=("zsh" "nvim" "tmux" "fzf" "git")
for dir in $dirs; do
  if [[ -d "$XDG_CONFIG_HOME/$dir" && ! -L "$XDG_CONFIG_HOME/$dir" ]]; then
    mv "$XDG_CONFIG_HOME/$dir" "$XDG_CONFIG_HOME/$dir".BAK
    printf "saving old $dir configuration at $XDG_CONFIG_HOME/$dir.BAK\n"
  fi
  if [[ -L "$XDG_CONFIG_HOME/$dir" ]]; then
    printf "$XDG_CONFIG_HOME/$dir is a link, skipping...\n"
  else
    ln -s "$SCRIPT_DIR/$dir" "$XDG_CONFIG_HOME"
    printf "configuration for $dir linked\n"
  fi
done

printf "Setup complete!\n"


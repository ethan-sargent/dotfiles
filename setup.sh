#!/bin/zsh
#
# Usage: Run when first pulling dotfiles to ensure configuration files are linked to the repo
#
# %x is the zsh equivalent of BASH_SOURCE; without it, running `zsh setup.sh`
# from another directory silently resolves SCRIPT_DIR to the caller's cwd
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-${(%):-%x}}" )" &> /dev/null && pwd )

# fetch vendored zsh plugins (powerlevel10k, fzf-tab) if the clone skipped submodules
if command -v git &> /dev/null && [[ -d "$SCRIPT_DIR/.git" || -f "$SCRIPT_DIR/.git" ]]; then
  printf "ensuring git submodules are initialised...\n"
  git -C "$SCRIPT_DIR" submodule update --init --recursive
fi

if [ -z $XDG_CONFIG_HOME ]; then
  printf "no existing XDG_CONFIG_HOME, using $HOME/.config\n"
  XDG_CONFIG_HOME="$HOME"/.config
else
  printf "XDG_CONFIG_HOME found! using $XDG_CONFIG_HOME\n"
fi

if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
  printf "no directory $XDG_CONFIG_HOME found, creating...\n"
  mkdir -p "$XDG_CONFIG_HOME"
fi

printf "linking minimal zshenv to $HOME/.zshenv\n"
if [[ ! -e "$HOME"/.zshenv && ! -L "$HOME"/.zshenv ]] then
  ln -s "$SCRIPT_DIR"/.zshenv "$HOME"/.zshenv
else
  printf "file found at $HOME/.zshenv, skipping...\n"
fi

printf "linking configuration now\n"
dirs=(zsh nvim tmux fzf git kitty tig bat wezterm alacritty)
for dir in $dirs; do
  if [[ -d "$XDG_CONFIG_HOME/$dir" && ! -L "$XDG_CONFIG_HOME/$dir" ]]; then
    mv "$XDG_CONFIG_HOME/$dir" "$XDG_CONFIG_HOME/$dir".BAK
    printf "saving old $dir configuration at $XDG_CONFIG_HOME/$dir.BAK\n"
  fi
  if [[ -d "$XDG_CONFIG_HOME/$dir" || -f "$XDG_CONFIG_HOME/$dir" || -L "$XDG_CONFIG_HOME/$dir" ]]; then
    printf "$XDG_CONFIG_HOME/$dir exists, skipping...\n"
  else
    ln -s "$SCRIPT_DIR/$dir" "$XDG_CONFIG_HOME"
    printf "configuration for $dir linked\n"
  fi
done

printf "Setup complete!\n"


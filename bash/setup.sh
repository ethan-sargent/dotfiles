#!/bin/bash
# Setup script for Vim 9 + Git Bash configuration
# Run once to create symlinks and install vim plugins
#
# Usage: bash setup.sh

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "=== Vim 9 + Git Bash Setup ==="
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# --- Create required directories ---
echo "Creating directories..."
mkdir -p "$XDG_CONFIG_HOME/bash"
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/vim/undo"
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/sfdx"

# --- Vim (XDG layout) ---
# Vim only falls back to $XDG_CONFIG_HOME/vim/vimrc when ~/.vimrc is absent,
# so move any existing one aside rather than linking to it.
echo "Linking vim config to $XDG_CONFIG_HOME/vim..."
if [[ -e ~/.vimrc || -L ~/.vimrc ]]; then
  echo "  Moving existing ~/.vimrc to ~/.vimrc.bak (it shadows the XDG config)"
  mv ~/.vimrc ~/.vimrc.bak
fi
# clean up the pre-XDG layout from earlier versions of this script
[[ -L ~/.vim/plugin ]] && rm ~/.vim/plugin

if [[ -d "$XDG_CONFIG_HOME/vim" && ! -L "$XDG_CONFIG_HOME/vim" ]]; then
  echo "  Backing up existing $XDG_CONFIG_HOME/vim to $XDG_CONFIG_HOME/vim.BAK"
  mv "$XDG_CONFIG_HOME/vim" "$XDG_CONFIG_HOME/vim.BAK"
fi
ln -sfn "$DOTFILES_DIR/vim" "$XDG_CONFIG_HOME/vim"

# --- Symlink bash configs ---
echo "Linking bash configs..."
if [[ -f ~/.inputrc && ! -L ~/.inputrc ]]; then
  echo "  Backing up existing ~/.inputrc to ~/.inputrc.bak"
  mv ~/.inputrc ~/.inputrc.bak
fi
ln -sfn "$DOTFILES_DIR/bash/.inputrc" ~/.inputrc

ln -sfn "$DOTFILES_DIR/bash/.bashrc" "$XDG_CONFIG_HOME/bash/.bashrc"
ln -sfn "$DOTFILES_DIR/bash/sfdx.bash" "$XDG_CONFIG_HOME/bash/sfdx.bash"

# --- Source .bashrc from ~/.bashrc ---
BASHRC_SOURCE='source "$XDG_CONFIG_HOME/bash/.bashrc"'
if [[ -f ~/.bashrc ]]; then
  if ! grep -qF "$BASHRC_SOURCE" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Dotfiles bash config" >> ~/.bashrc
    echo "export XDG_CONFIG_HOME=\"\${XDG_CONFIG_HOME:-\$HOME/.config}\"" >> ~/.bashrc
    echo "$BASHRC_SOURCE" >> ~/.bashrc
    echo "  Added source line to ~/.bashrc"
  else
    echo "  ~/.bashrc already sources dotfiles config"
  fi
else
  echo "export XDG_CONFIG_HOME=\"\${XDG_CONFIG_HOME:-\$HOME/.config}\"" > ~/.bashrc
  echo "$BASHRC_SOURCE" >> ~/.bashrc
  echo "  Created ~/.bashrc with source line"
fi

# --- Install Vim plugins via native pack system ---
# Lives inside the (symlinked) XDG vim dir; the repo gitignores vim/pack/
echo ""
echo "Installing vim plugins..."
PACK_DIR="$DOTFILES_DIR/vim/pack/vendor/start"
mkdir -p "$PACK_DIR"

install_plugin() {
  local repo="$1"
  local name="$2"
  local dest="$PACK_DIR/$name"

  if [[ -d "$dest" ]]; then
    echo "  $name: already installed, pulling latest..."
    git -C "$dest" pull --quiet 2>/dev/null || echo "  $name: pull failed, using existing"
  else
    echo "  $name: cloning from $repo..."
    git clone --quiet "https://github.com/$repo.git" "$dest"
  fi
}

install_plugin "tpope/vim-surround" "vim-surround"
install_plugin "tpope/vim-commentary" "vim-commentary"
install_plugin "tpope/vim-fugitive" "vim-fugitive"
install_plugin "catppuccin/vim" "catppuccin"

# --- Generate helptags ---
echo ""
echo "Generating helptags..."
# packloadall so pack/vendor/start plugin docs are on runtimepath (-u NONE skips packages)
vim -N -es -c "packloadall | silent! helptags ALL" -c "qa!" 2>/dev/null || true

# --- Done ---
echo ""
echo "=== Setup Complete ==="
echo ""
echo "Configuration files:"
echo "  $XDG_CONFIG_HOME/vim   -> $DOTFILES_DIR/vim"
echo "  ~/.inputrc             -> $DOTFILES_DIR/bash/.inputrc"
echo "  $XDG_CONFIG_HOME/bash/ -> $DOTFILES_DIR/bash/"
echo ""
echo "Vim plugins installed:"
ls -1 "$PACK_DIR" 2>/dev/null | sed 's/^/  /'
echo ""
echo "Restart your shell or run: source ~/.bashrc"

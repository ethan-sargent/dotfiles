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
mkdir -p ~/.vim/undodir
mkdir -p ~/.vim/pack/vendor/start
mkdir -p "$XDG_CONFIG_HOME/bash"
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/sfdx"

# --- Symlink vimrc ---
echo "Linking vimrc..."
if [[ -f ~/.vimrc && ! -L ~/.vimrc ]]; then
  echo "  Backing up existing ~/.vimrc to ~/.vimrc.bak"
  mv ~/.vimrc ~/.vimrc.bak
fi
ln -sfn "$DOTFILES_DIR/vim/vimrc" ~/.vimrc

# --- Symlink vim plugin directory ---
echo "Linking vim plugin directory..."
if [[ -d ~/.vim/plugin && ! -L ~/.vim/plugin ]]; then
  echo "  Backing up existing ~/.vim/plugin to ~/.vim/plugin.bak"
  mv ~/.vim/plugin ~/.vim/plugin.bak
fi
# -n: replace an existing dir symlink instead of linking inside it
ln -sfn "$DOTFILES_DIR/vim/plugin" ~/.vim/plugin

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
echo ""
echo "Installing vim plugins..."
PACK_DIR="$HOME/.vim/pack/vendor/start"

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
echo "  ~/.vimrc          -> $DOTFILES_DIR/vim/vimrc"
echo "  ~/.vim/plugin/    -> $DOTFILES_DIR/vim/plugin/"
echo "  ~/.inputrc        -> $DOTFILES_DIR/bash/.inputrc"
echo "  ~/.config/bash/   -> $DOTFILES_DIR/bash/"
echo ""
echo "Vim plugins installed:"
ls -1 "$PACK_DIR" 2>/dev/null | sed 's/^/  /'
echo ""
echo "Restart your shell or run: source ~/.bashrc"

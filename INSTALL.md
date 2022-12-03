# Installation

## Config 

* zsh-only
* run setup.sh to create and symlink config folders
  * this will backup non-linked config folders to .config/CONFIG_PROGRAM_BAK
* copy alacritty file based on OS to .config/alacritty/alacritty.yml
* install starship
* copy zshrc and zshenv
* install oh-my-tmux
* symlink tmux configuration files

## Tools 

* alacritty
* neovim
* starship
* fd-find
* fzf
* rg
* volta (oxidised nvm)
* sfdx cli
* zoxide
* exa

## nvim cmake flags:

make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=mold -DCMAKE_C_COMPILER=clang"

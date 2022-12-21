# Installation

## Config 

* zsh-only
* run setup.sh to create and symlink config folders
  * this will backup non-linked config folders to .config/CONFIG_PROGRAM_BAK
* copy alacritty file based on OS to .config/alacritty/alacritty.yml
* copy zshrc and zshenv

## Tools 

* alacritty
* neovim
* starship
* fd-find
* fzf
* rg - ergonomic ripgrep
* volta - oxidised NVM (node version manager)
* sfdx cli
* zoxide - directory jumper 
* exa

## nvim cmake flags:

make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=mold -DCMAKE_C_COMPILER=clang"

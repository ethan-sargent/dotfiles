
## Installation:
My prompt uses powerlevel10k (https://github.com/romkatv/powerlevel10k) - use the below command to clone the p10k repo automatically.

```
git clone https://github.com/ethan-sargent/dotfiles --recurse-submodules
```
For further details, see INSTALL.md - config installation should be as simple as running setup.sh.
Please take a backup of your config before executing it!
I've smoke-tested my script to check it won't nuke configs, and it should rename folders to config_dir.BAK - but I don't know if there are edge cases where it might break.


## Dependencies and Tools

### Core

* Neovim 
* Alacritty (OpenGL terminal emulator)
* Tmux (terminal multiplexer - tabs/splits/layouts
* Starship (prompt customisation)

### CLI utils
* ripgrep (very fast file searches incl contents)
* fzf (fuzzy find)
* zoxide (cd)
* exa (ls replacement)
* fd-find (ergonomic search-by-name)

### Toolchains

* rustup
* volta (node version manager)



## Installation:
My prompt uses powerlevel10k (https://github.com/romkatv/powerlevel10k) - use the below command to clone the p10k repo 
automatically as a submodule in the correct location for it to autoload.

```
git clone https://github.com/ethan-sargent/dotfiles --recurse-submodules
```
To apply the configuration see INSTALL.md - config installation should be as simple as running setup.sh.

Make sure you take a backup of your XDG_CONFIG_HOME dir before executing it! 
it _should_ back up any existing config rather than overwrite it, but cannot guarantee this.

### Core

* Neovim 
* Kitty - performant terminal with built-in layout management
* Powerlevel10k (async prompt customisation)

### CLI utils

* ripgrep 
* fzf (fuzzy find) - additional support for fuzzy search and doc preview of SFDX commands
* zoxide (cd) - directory jumper
* exa (ls replacement) - better cross platform color support
* fd-find - GNU find replacement

### Toolchains

* rustup - Rust
* volta (node version manager) - NodeJS/NPM shim



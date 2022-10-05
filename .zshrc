# Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory


# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export JAVA_HOME="$HOME/.graalvm/graalvm-ce-java17-22.2.0"
export PATH=$PATH:$JAVA_HOME/bin
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=":$PATH"
export PATH="/mnt/c/Users/ethan.sargent/AppData/Local/Programs/Microsoft VS Code/bin/:$PATH"
LC_ALL=en_US.UTF-8
export DENO_INSTALL="/home/ethandev/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export TERM="screen-256color"
export PATH=$PATH:/usr/local/go/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias sfdx-fzf-refresh="sfdx commands --json > ~/.sfdxcommands.json"
alias vim="/usr/local/bin/nvim"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
export VISUAL="nvim"
export EDITOR="$VISUAL"

alias luamake=/home/ethandev/.lsp/lua-language-server/3rd/luamake/luamake
# bun completions
[ -s "/home/ethandev/.bun/_bun" ] && source "/home/ethandev/.bun/_bun"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

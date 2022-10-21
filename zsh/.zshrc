#!/bin/zsh
# zmodload zsh/zprof

setopt histignorealldups sharehistory histignorespace

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history


if [[ -d "$HOME/Library/Caches/sfdx/autocomplete/functions/zsh" ]]; then
	fpath=( "$HOME/Library/Caches/sfdx/autocomplete/functions/zsh" $fpath);
fi

# Use modern completion system
autoload -Uz compinit 
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots) # With hidden files

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

zstyle ':completion:*' completer _complete _approximate _extensions
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes 
zstyle ':completion:*' expand prefix suffix 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' complete-options true

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' menu select
export CLICOLOR=1
zstyle ':completion:*' menu select
 
export LC_ALL=en_US.UTF-8
export TERM="screen-256color"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > .sfdxcommands.json"
alias vim="nvim"
alias ls="exa"

export PATH=$PATH:$HOME/.local/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH


# export PATH="/usr/local/opt/node@16/bin:$PATH"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export SFDX_AC_ZSH_SETUP_PATH=/Users/ethan.sargent/Library/Caches/sfdx/autocomplete/zsh_setup && test -f $SFDX_AC_ZSH_SETUP_PATH && source $SFDX_AC_ZSH_SETUP_PATH; # sfdx autocomplete setup

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# zprof

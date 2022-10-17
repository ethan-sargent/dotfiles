#!/usr/bin/zsh
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

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' format 'Completing %d'

zstyle ':completion:*' menu select
export CLICOLOR=1
zstyle ':completion:*' menu select
 
export LC_ALL=en_US.UTF-8
export TERM="screen-256color"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > .sfdxcommands.json"
alias vim="/usr/local/bin/nvim"
alias ls="exa"

export PATH=$PATH:$HOME/.local/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export SFDX_AC_ZSH_SETUP_PATH=/Users/ethan.sargent/Library/Caches/sfdx/autocomplete/zsh_setup && test -f $SFDX_AC_ZSH_SETUP_PATH && source $SFDX_AC_ZSH_SETUP_PATH; # sfdx autocomplete setup

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# zprof

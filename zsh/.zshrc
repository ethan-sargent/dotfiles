#!/bin/zsh
# enable profiling startup time
zmodload zsh/zprof
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt histignorealldups sharehistory histignorespace

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
export LC_ALL=en_US.UTF-8

# setup vim bindings
source "$ZDOTDIR"/bindings.zsh

# setup completion system
source "$ZDOTDIR"/completion.zsh
 
# ensure setup SFDX FZF Keybinds extension
# https://github.com/surajp/fzf-sfdx
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > .sfdxcommands.json"
# apply aliases if installed
command -v nvim > /dev/null 2>&1  && { alias vim="nvim" } 
command -v exa > /dev/null 2>&1   && { alias ls="exa"   } 

export PATH=$PATH:$HOME/.local/bin

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

eval "$(zoxide init zsh)"

# Volta - Version Manager 
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
source ~/powerlevel10k/powerlevel10k.zsh-theme
[ -f ~/.config/zsh/.p10k.zsh ] && source ~/.config/zsh/.p10k.zsh
zprof

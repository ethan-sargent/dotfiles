#!/bin/zsh
# enable profiling startup time
# zmodload zsh/zprof

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
[ -f "$ZDOTDIR"/plugins/fzf/fzf.zsh ] && source "$ZDOTDIR"/plugins/fzf/fzf.zsh 


# ensure .local/bin is on path
export PATH=$PATH:$HOME/.local/bin

# setup aliases
source "$ZDOTDIR/aliases.zsh"

# export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home
# export PATH=$JAVA_HOME/bin:$PATH

eval "$(zoxide init zsh)"

# Volta - Version Manager 
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# Moved default installation directory to ensure inclusion in repo
source "$ZDOTDIR"/plugins/powerlevel10k/powerlevel10k.zsh-theme
[ -f "$ZDOTDIR"/.p10k.zsh ] && source "$ZDOTDIR"/.p10k.zsh
# end profiling
# zprof

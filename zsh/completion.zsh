#!/bin/zsh

# sfdx autocomplete setup
if [[ -d "$HOME/Library/Caches/sfdx/autocomplete/functions/zsh" ]]; then
  fpath=(
  "$HOME/Library/Caches/sfdx/autocomplete/functions/zsh"
  $fpath
  );
fi
if [[ -f "$XDG_CACHE_HOME/sfdx/autocomplete/functions/zsh" ]]; then
  fpath=(
  "$XDG_CACHE_HOME/sfdx/autocomplete/functions/zsh" 
  $fpath
  );
fi
# sf autocomplete setup
if [[ -d "$HOME/Library/Caches/sf/autocomplete/functions/zsh" ]]; then
  fpath=(
  "$HOME/Library/Caches/sf/autocomplete/functions/zsh"
  $fpath
  );
fi
if [[ -d "$XDG_CACHE_HOME/sf/autocomplete/functions/zsh" ]]; then
  fpath=(
  "$XDG_CACHE_HOME/sf/autocomplete/functions/zsh" 
  $fpath
  );
fi


# brew completion support
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi


# Use modern completion system with caches
autoload -Uz compinit 
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots) # With hidden files

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.

zstyle ':completion:*' completer _complete _approximate _extensions _prefix
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=*'

# group completions under their description
zstyle ':completion:*' group-name ''

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' complete-options true
zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}"

# zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan}-- %D %d --%f'
# zstyle ':completion:*:*:*:*:messages' format ' %F{purple}-- %d --%f'
# zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*' menu select
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '-- %d --'


# FZF Tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# zstyle ':fzf-tab:complete:*' fzf-preview 'less $realpath'
# zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word'
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# Replace completion menu with fzf if installed
(($+commands[fzf])) && {
  source "$ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh"
} 

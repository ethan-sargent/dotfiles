#!/bin/zsh

# sfdx autocomplete setup
# macos only atm
if [[ -f "$HOME/Library/Caches/sfdx/autocomplete/zsh_setup" ]]; then
  source  "$HOME/Library/Caches/sfdx/autocomplete/zsh_setup" 
fi


# brew completion support
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# bunjs completions
[ -s "/usr/local/Cellar/bun/0.3.0/share/zsh/site-functions/_bun" ] && source "/usr/local/Cellar/bun/0.3.0/share/zsh/site-functions/_bun"


# Use modern completion system with caches
autoload -Uz compinit 
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots) # With hidden files

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.

zstyle ':completion:*' completer _complete _approximate _extensions
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

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' menu select

# Replace completion menu with fzf if installed

# FZF Tab recommended configuration
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
(($+commands[fzf])) && {
  source "$ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh"
} 

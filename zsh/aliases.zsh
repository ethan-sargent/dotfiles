# alias commands if they exist
# preferred format for speed with zsh

(($+commands[nvim]))  && { alias vim="nvim" } 
(($+commands[exa]))   && { alias ls="exa"   } 
(($+commands[bat]))   && { alias cat="bat"  } 
(($+commands[just]))  && { alias j="just"   } 
(($+commands[git]))   && { alias g="git"    } 

alias azco="az repos pr checkout --id"


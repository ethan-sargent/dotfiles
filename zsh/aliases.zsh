# alias commands if they exist
# preferred format for speed with zsh

(($+commands[nvim]))  && { alias vim="nvim" } 
(($+commands[exa]))   && { alias ls="exa"   } 
(($+commands[bat]))   && { alias cat="bat"  } 
(($+commands[just]))  && { alias j="just"   } 
(($+commands[git]))   && { alias g="git"    } 

# checkout branch and pull latest changes
azco() {
  az repos pr checkout --id "$1"
  g pull
}

azcocheck() {
  azco "$1"
  g log --oneline
}



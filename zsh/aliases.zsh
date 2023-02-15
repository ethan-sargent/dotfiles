# alias commands if they exist
# preferred format for speed with zsh

(($+commands[nvim]))  && { 
  alias vim="nvim"
  alias v="nvim"
} 
(($+commands[exa]))   && { alias ls="exa"   } 
(($+commands[bat]))   && { alias cat="bat"  } 
(($+commands[just]))  && { alias j="just"   } 
(($+commands[git]))   && { alias g="git"    } 
(($+commands[lazygit]))   && { alias lg="lazygit"    } 

# checkout branch and pull latest changes
azco() {
  az repos pr checkout --id "$1"
  g pull
}

azcocheck() {
  azco "$1"
  g log --oneline
}

colormap(){
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

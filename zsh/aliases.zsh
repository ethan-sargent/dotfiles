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

# checkout branch from PR ID
azco() {
  az repos pr checkout --id "$1"
}


azactiveitems() {
  az boards query --id 84fdd6d1-16e5-4ff2-9b38-abac3489b21b -o table --query '[].{ID: id, Title: fields."System.Title", State:fields."System.State", Tags:fields."System.Tags"}'
}

colormap(){
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

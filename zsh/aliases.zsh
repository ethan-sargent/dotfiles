
alias sfdx-fzf-refresh="sfdx commands --json | jq '. | unique' > .sfdxcommands.json"


# alias commands if they exist
# preferred format for speed with zsh

(($+commands[nvim]))  && { alias vim="nvim" } 
(($+commands[exa]))   && { alias ls="exa"   } 
(($+commands[bat]))   && { alias cat="bat"   } 

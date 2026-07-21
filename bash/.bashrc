#!/bin/bash
# Git Bash (mingw) Configuration
# Ported from zsh/.zshrc and zsh/.zshenv
# Designed for restricted remote development environment

# === Early Exit for Non-Interactive Shells ===
[[ $- != *i* ]] && return

# === XDG Base Directories ===
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# === Editor ===
export VISUAL=vim
export EDITOR=vim

# === Locale ===
export LC_ALL=en_US.UTF-8

# === PATH ===
export PATH="$HOME/.local/bin:$HOME/local/bin:$PATH"

# === Salesforce CLI ===
export SF_AUTOUPDATE_DISABLE=true
export SF_SKIP_NEW_VERSION_CHECK=true
export SF_DISABLE_TELEMETRY=true
# Suppress punycode deprecation warning from SF CLI dependency
export NODE_OPTIONS='--disable-warning=DEP0040'

# === History ===
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# === Shell Options ===
shopt -s checkwinsize   # Update LINES/COLUMNS after each command
shopt -s globstar 2>/dev/null  # ** glob pattern (bash 4+)
shopt -s nocaseglob     # Case-insensitive globbing
shopt -s cdspell        # Autocorrect typos in cd

# === Vi Mode ===
set -o vi

# === Aliases ===
alias g='git'
alias v='vim'
alias la='ls -la'
alias ll='ls -l'
alias gs='git status -uno'
alias gd='git diff'
alias gl='git log --oneline -20'

# === SFDX Shell Functions ===
if [[ -f "$XDG_CONFIG_HOME/bash/sfdx.bash" ]]; then
  source "$XDG_CONFIG_HOME/bash/sfdx.bash"
fi

# === Git Prompt (shipped with Git Bash) ===
# __git_ps1 is provided by git-prompt.sh in Git for Windows

# Source git-prompt if not already loaded
if ! type -t __git_ps1 &>/dev/null; then
  for f in \
    /etc/bash_completion.d/git-prompt \
    /usr/share/git/completion/git-prompt.sh \
    /mingw64/share/git/completion/git-prompt.sh \
    "/c/Program Files/Git/mingw64/share/git/completion/git-prompt.sh"; do
    if [[ -f "$f" ]]; then
      source "$f"
      break
    fi
  done
fi

# Git prompt config
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

# === SFDX Org in Prompt ===
__sfdx_org_ps1() {
  if [[ -f .sfdx/sfdx-config.json ]]; then
    node -e "
      try {
        const c = require('./.sfdx/sfdx-config.json');
        const org = c['target-org'] || c['defaultusername'] || '';
        if (org) process.stdout.write(' [' + org + ']');
      } catch(e) {}
    " 2>/dev/null
  fi
}

# === Prompt ===
# Two-line prompt: path + git branch + sfdx org on line 1, prompt char on line 2
__build_prompt() {
  local exit_code=$?
  local reset='\[\e[0m\]'
  local blue='\[\e[34m\]'
  local green='\[\e[32m\]'
  local cyan='\[\e[36m\]'
  local red='\[\e[31m\]'
  local yellow='\[\e[33m\]'
  local bold='\[\e[1m\]'

  # Directory
  PS1="${bold}${blue}\w${reset}"

  # Git branch
  if type -t __git_ps1 &>/dev/null; then
    PS1+="${green}$(__git_ps1 ' (%s)')${reset}"
  fi

  # SFDX org
  PS1+="${cyan}$(__sfdx_org_ps1)${reset}"

  # Newline + prompt char (color based on last exit code)
  if [[ $exit_code -eq 0 ]]; then
    PS1+="\n${green}>${reset} "
  else
    PS1+="\n${red}>${reset} "
  fi
}

PROMPT_COMMAND='__build_prompt'

# === Git Bash Completion ===
# Git for Windows ships bash completion
for f in \
  /etc/bash_completion \
  /mingw64/share/git/completion/git-completion.bash \
  "/c/Program Files/Git/mingw64/share/git/completion/git-completion.bash"; do
  if [[ -f "$f" ]]; then
    source "$f"
    break
  fi
done

# === SF CLI Bash Completions ===
if command -v sf &>/dev/null; then
  eval "$(sf autocomplete:script bash 2>/dev/null)" || true
fi

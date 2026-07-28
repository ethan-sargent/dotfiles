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

# === Prompt ===
# Git Bash's stock prompt (path + branch via /etc/profile.d/git-prompt.sh)
# is kept as-is: a custom PROMPT_COMMAND spawning node/git per prompt adds
# noticeable latency on Windows. Use dxenv for the current org on demand.

# === Bell ===
# belt-and-braces with .inputrc in case it isn't linked
bind 'set bell-style none' 2>/dev/null

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

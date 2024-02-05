# macOS
if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
  export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/Documents}
  export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
  export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/Music}
  export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
  export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/Videos}
  export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
  if [[ -d /opt/homebrew ]]; then
    export HOMEBREW_PREFIX=/opt/homebrew
  else
    export HOMEBREW_PREFIX=/usr/local
  fi
  export BROWSER='open'
fi

# disables shell session storage
export SHELL_SESSIONS_DISABLE=1

# editor
if (($+commands[nvim])) then 
  export VISUAL="nvim"
  export EDITOR="nvim"
else
  export VISUAL="vim"
  export EDITOR="vim"
fi

export SF_DISABLE_TELEMETRY=true

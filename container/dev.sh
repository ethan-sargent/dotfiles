#!/usr/bin/env bash
# Host-side helper for the dotfiles dev container (podman).
#
# Usage:
#   ./container/dev.sh build            build/rebuild the image
#   ./container/dev.sh [shell]          open a shell (default command)
#   ./container/dev.sh run <cmd...>     run a one-off command in the container
#   ./container/dev.sh bootstrap        force a full bootstrap re-run, then shell
#   ./container/dev.sh nuke             DELETE the home volume (all persisted state)
set -euo pipefail

# --- user-editable config --------------------------------------------------
IMAGE="localhost/dotfiles-dev"
VOLUME="dotfiles-dev-home"
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/ethan-sargent/dotfiles.git}"
# host:container bind mounts for project access; add more entries as needed
MOUNTS=(
  "$HOME/Projects:/home/dev/Projects"
)
# ----------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

is_mac() { [[ "$(uname -s)" == "Darwin" ]]; }

# Remote podman (macOS/Windows podman machine) does its own UID mapping and has
# no host SELinux to satisfy; native Linux rootless needs keep-id and, when
# SELinux is enforcing, :z labels on bind mounts.
is_remote_podman() {
  [[ "$(podman info --format '{{.Host.ServiceIsRemote}}' 2>/dev/null)" == "true" ]]
}

selinux_enabled() {
  [[ "$(podman info --format '{{.Host.Security.SELinuxEnabled}}' 2>/dev/null)" == "true" ]]
}

userns_args() {
  if ! is_remote_podman; then
    echo "--userns=keep-id:uid=1000,gid=1000"
  fi
}

mount_args() {
  local suffix=""
  if ! is_remote_podman && selinux_enabled; then
    suffix=":z"
  fi
  local m
  for m in "${MOUNTS[@]}"; do
    local host_path="${m%%:*}"
    if [[ ! -d "$host_path" ]]; then
      echo "warning: mount source $host_path does not exist, skipping" >&2
      continue
    fi
    echo "-v" "${m}${suffix}"
  done
}

# Forward the SSH agent when one is available so git-over-ssh works inside.
ssh_args() {
  if is_mac; then
    # podman machine forwards the host agent to this path inside the VM
    echo "-v" "/run/host-services/ssh-auth.sock:/ssh-agent" \
         "-e" "SSH_AUTH_SOCK=/ssh-agent"
  elif [[ -n "${SSH_AUTH_SOCK:-}" && -S "${SSH_AUTH_SOCK:-}" ]]; then
    local suffix=""
    selinux_enabled && suffix=":z"
    echo "-v" "$SSH_AUTH_SOCK:/ssh-agent$suffix" "-e" "SSH_AUTH_SOCK=/ssh-agent"
  fi
}

cmd_build() {
  local sha
  sha="$(git -C "$SCRIPT_DIR/.." rev-parse --short HEAD 2>/dev/null || echo nogit)"
  podman build \
    --build-arg BUILD_ID="$(date +%s)-$sha" \
    -t "$IMAGE" \
    -f "$SCRIPT_DIR/Containerfile" \
    "$SCRIPT_DIR"
}

run_container() {
  # shellcheck disable=SC2046
  podman run --rm -it \
    $(userns_args) \
    -v "$VOLUME:/home/dev" \
    $(mount_args) \
    $(ssh_args) \
    -e DOTFILES_REPO="$DOTFILES_REPO" \
    -e TERM="${TERM:-xterm-256color}" \
    "$IMAGE" "$@"
}

cmd_shell()     { run_container; }
cmd_run()       { run_container "$@"; }
cmd_bootstrap() { run_container bash -c 'container-bootstrap --force && exec zsh -l'; }

cmd_nuke() {
  echo "This DELETES the '$VOLUME' volume: your in-container home directory,"
  echo "including ~/.claude (sessions, memory, credentials), shell history,"
  echo "the dotfiles clone, and all installed runtimes."
  read -r -p "Type the volume name ('$VOLUME') to confirm: " answer
  if [[ "$answer" == "$VOLUME" ]]; then
    podman volume rm "$VOLUME"
    echo "Volume removed. Next shell will bootstrap from scratch."
  else
    echo "Aborted."
  fi
}

case "${1:-shell}" in
  build)     cmd_build ;;
  shell)     cmd_shell ;;
  run)       shift; cmd_run "$@" ;;
  bootstrap) cmd_bootstrap ;;
  nuke)      cmd_nuke ;;
  *)
    echo "Usage: $0 {build|shell|run <cmd...>|bootstrap|nuke}" >&2
    exit 1
    ;;
esac

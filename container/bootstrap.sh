#!/bin/bash
# Idempotent first-run/upgrade bootstrap for the dev container home volume.
# Runs on every container start (cheap when already bootstrapped); re-run in
# full with `container-bootstrap --force` or automatically after an image
# rebuild (BUILD_ID stamp mismatch).
set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/ethan-sargent/dotfiles.git}"
DOTFILES_DIR="$HOME/dotfiles"
STAMP="$HOME/.cache/container-bootstrap.done"
IMAGE_BUILD_ID="$(cat /etc/container-image-build 2>/dev/null || echo unknown)"
FORCE=0
[[ "${1:-}" == "--force" ]] && FORCE=1

log() { printf '[bootstrap] %s\n' "$*"; }

# --- always-on self-healing checks (cheap) --------------------------------
mkdir -p "$HOME/.cache/zsh" "$HOME/.local/bin"

if [[ ! -d "$DOTFILES_DIR/.git" ]]; then
  log "cloning dotfiles from $DOTFILES_REPO"
  git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

if [[ ! -L "$HOME/.zshenv" && ! -e "$HOME/.zshenv" ]]; then
  log "running setup.sh"
  (cd "$DOTFILES_DIR" && zsh setup.sh)
fi

# --- full pass: first run, image upgrade, or --force ----------------------
if [[ $FORCE -eq 0 && -f "$STAMP" && "$(cat "$STAMP")" == "$IMAGE_BUILD_ID" ]]; then
  exit 0
fi

log "full bootstrap (image build: $IMAGE_BUILD_ID)"

git -C "$DOTFILES_DIR" submodule update --init --recursive
(cd "$DOTFILES_DIR" && zsh setup.sh)

if [[ ! -x "$HOME/.local/bin/claude" ]] && ! command -v claude &> /dev/null; then
  log "installing Claude Code"
  curl -fsSL https://claude.ai/install.sh | bash
fi

if [[ -f "$HOME/.config/mise/config.toml" ]]; then
  log "installing mise-managed runtimes"
  mise install || log "mise install failed (non-fatal)"
fi

echo "$IMAGE_BUILD_ID" > "$STAMP"
log "done"

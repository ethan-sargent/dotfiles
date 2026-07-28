#!/bin/bash
# Bootstrap the home volume, then hand over to an interactive shell (default)
# or whatever command was passed to `podman run`.
/usr/local/bin/container-bootstrap || echo "[entrypoint] bootstrap failed; continuing anyway (re-run with: container-bootstrap --force)" >&2

if [[ $# -gt 0 ]]; then
  exec "$@"
fi
exec zsh -l

# Dev container

A Fedora-based podman container that boots straight into this dotfiles setup:
zsh + powerlevel10k, neovim (lazy.nvim), tmux, and the core CLI toolkit, with
Claude Code and mise installed. The entire container home directory lives on a
named volume, so everything you change inside persists across containers and
image rebuilds.

## Quick start

```sh
./container/dev.sh build   # build the image (rerun to pick up Containerfile changes)
./container/dev.sh         # open a shell (bootstraps the home volume on first run)
```

First run clones this repo (with submodules) into `~/dotfiles` inside the
volume, runs `setup.sh`, and installs Claude Code into `~/.local/bin`.
Subsequent shells start in about a second.

Containers are ephemeral (`podman run --rm`) — one per shell, always running
the latest built image. State lives in the volume, not the container. The one
consequence: a process you leave running (e.g. a dev server) dies when that
shell exits, unless it's inside a tmux session in the same shell.

## What's in the image

Via dnf: `zsh git neovim tmux fzf ripgrep fd-find bat jq zoxide eza less unzip
tar gcc gcc-c++ make openssh-clients ca-certificates glibc-langpack-en sudo
which procps-ng`, plus `mise` from its official rpm repo. The compilers exist
for nvim-treesitter parser builds and mason. Language runtimes (node, python,
…) are intentionally not baked in — use `mise use node@lts` etc. per project;
they install into the home volume and persist.

## What persists (the `dotfiles-dev-home` volume)

Everything under `/home/dev`, notably:

- `~/dotfiles` — your clone; edit, commit, and push from inside the container
- `~/.claude` — Claude Code sessions/transcripts, memory, settings, credentials
- shell history, nvim plugins/mason tools, tmux plugins, mise runtimes

Rebuilding the image (`dev.sh build`) never touches the volume; the next shell
re-runs the bootstrap against the new image (idempotent). `dev.sh nuke`
deletes the volume after confirmation — that is the only destructive command.

## Host file access

Edit the `MOUNTS` array at the top of `dev.sh`. Default: `~/Projects` →
`/home/dev/Projects`. On SELinux hosts the script adds `:z` automatically; on
macOS/Windows it drops Linux-only flags.

macOS note: mounts must be under a path shared with the podman machine
(`$HOME` is shared by default on current podman). If a mount comes up empty,
check `podman machine inspect --format '{{.Mounts}}'`.

## Per-OS setup

- **Linux**: install podman; nothing else. The script uses
  `--userns=keep-id` so files you create in mounted project dirs are owned by
  you on the host.
- **macOS**: `podman machine init && podman machine start` once, then use
  `dev.sh` as normal.
- **Windows**: run podman machine (`podman machine init/start`) and use
  `dev.sh` from a WSL shell or Git Bash; or use native rootless podman inside
  a WSL distro, which behaves like Linux.

## Git auth inside the container

`dev.sh` forwards your SSH agent when it can:

- **Linux/WSL**: mounts `$SSH_AUTH_SOCK` when set.
- **macOS**: mounts the podman machine's forwarded agent socket
  (`/run/host-services/ssh-auth.sock`).
- **Windows-side agents** (e.g. 1Password on Windows with WSL): need
  npiperelay/wsl-ssh-agent to expose a socket in WSL first.

Fallback that always works: HTTPS remotes plus a credential helper or
`gh auth login` run inside the container — credentials persist in the volume.

## Commands

| Command | Effect |
|---|---|
| `dev.sh build` | Build/rebuild the image |
| `dev.sh` / `dev.sh shell` | Open a shell |
| `dev.sh run <cmd…>` | One-off command (e.g. `dev.sh run claude --version`) |
| `dev.sh bootstrap` | Force a full bootstrap re-run, then shell |
| `dev.sh nuke` | Delete the home volume (asks for confirmation) |

## Troubleshooting

- **Prompt loads without powerlevel10k** — submodules missing; run
  `git -C ~/dotfiles submodule update --init --recursive` (setup.sh also does
  this now).
- **Bootstrap failed on start** (e.g. no network): you still get a shell; fix
  connectivity and run `container-bootstrap --force`.
- **Permission denied on project mounts (Linux)** — SELinux labeling; the
  script adds `:z`, but a directory shared with other tools may need
  `podman unshare` inspection or a different mount point.
- **Fresh start** — `dev.sh nuke`, then `dev.sh` (full re-bootstrap).

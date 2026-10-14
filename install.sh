#!/usr/bin/env bash
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
FORCE=0
UNINSTALL=0

usage() {
  echo "Usage: ./install.sh [--dry-run] [--force] [--uninstall]"
}

link_one() {
  local src="$1" dest="$2"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "[dry-run] $dest -> $src"
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ]; then
    ln -sfn "$src" "$dest"
    echo "linked $dest -> $src"
  elif [ -e "$dest" ]; then
    if [ "$FORCE" -eq 1 ]; then
      mkdir -p "$BACKUP_DIR"
      mv "$dest" "$BACKUP_DIR/"
      ln -sfn "$src" "$dest"
      echo "backed up + linked $dest"
    else
      mkdir -p "$BACKUP_DIR"
      mv "$dest" "$BACKUP_DIR/"
      ln -sfn "$src" "$dest"
      echo "backed up $dest to $BACKUP_DIR, linked -> $src"
    fi
  else
    ln -sfn "$src" "$dest"
    echo "linked $dest -> $src"
  fi
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --force) FORCE=1 ;;
    --uninstall) UNINSTALL=1 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "unknown flag: $arg"; usage; exit 1 ;;
  esac
done

OS="$(uname -s)"
VSCODE_SETTINGS=""
case "$OS" in
  Linux) VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json" ;;
  Darwin) VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json" ;;
  *) echo "unsupported OS: $OS"; exit 1 ;;
esac
if grep -qi microsoft /proc/version 2>/dev/null || [ -n "${WSL_DISTRO_NAME:-}" ]; then
  echo "WSL detected"
fi

if [ "$UNINSTALL" -eq 1 ]; then
  for f in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.inputrc" "$HOME/.shell_common" "$HOME/.bash_aliases" "$HOME/.gitconfig" "$HOME/.gitignore_global" "$HOME/.tmux.conf"; do
    [ -L "$f" ] && rm "$f" && echo "removed $f"
  done
  echo "uninstall done (backups kept under ~/.dotfiles_backup/)"
  exit 0
fi

link_one "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
link_one "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
link_one "$DOTFILES_DIR/bash/.inputrc" "$HOME/.inputrc"
link_one "$DOTFILES_DIR/bash/.shell_common" "$HOME/.shell_common"
link_one "$DOTFILES_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"
link_one "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_one "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
link_one "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
link_one "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_one "$DOTFILES_DIR/nvim/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"

if [ "$DRY_RUN" -eq 1 ]; then
  echo "[dry-run] $VSCODE_SETTINGS -> $DOTFILES_DIR/vscode/settings.json (manual copy, not symlinked)"
else
  echo "VS Code: manually copy vscode/settings.json to: $VSCODE_SETTINGS"
  echo "See vscode/README.md for extensions restore."
fi

echo "done."

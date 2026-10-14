# dotfiles

Portable bash-core dotfiles. Linux + macOS + WSL. Zero-dependency install.

## Quick start

```bash
git clone https://github.com/adineo-cmd/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh --dry-run   # preview
./install.sh             # link + backup to ~/.dotfiles_backup/<timestamp>/
```

## Restore VS Code

```bash
cat vscode/extensions.txt | xargs -L1 code --install-extension
```

See `docs/SETUP.md` for fresh-machine steps per OS.

## Secrets rule

Never commit `*.local`, tokens, `.ssh/`, `.gnupg/`, `.env`. Use `*.example` templates.

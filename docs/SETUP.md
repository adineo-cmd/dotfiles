# Fresh-machine setup

## Ubuntu 24.04

```bash
sudo apt update && sudo apt install -y git curl tmux neovim fzf shellcheck
# starship (optional): curl -sS https://starship.rs/install.sh | sh
git clone https://github.com/adineo-cmd/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

## macOS

```bash
xcode-select --install
brew install git tmux neovim fzf starship shellcheck
git clone https://github.com/adineo-cmd/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

## WSL2 (Ubuntu)

Same as Ubuntu. VS Code: use Windows-side VS Code + Remote-WSL; settings sync from Linux path `~/.config/Code/User/settings.json`.

## VS Code extensions

```bash
code --list-extensions > vscode/extensions.txt   # refresh list before commit
cat vscode/extensions.txt | xargs -L1 code --install-extension
```

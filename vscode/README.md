# VS Code

- `settings.json` is the portable subset (Windows-only terminal profiles + absolute background image path stripped).
- Refresh: `code --list-extensions > vscode/extensions.txt`
- Restore: `cat vscode/extensions.txt | xargs -L1 code --install-extension`
- Linux target: `~/.config/Code/User/settings.json`
- macOS target: `~/Library/Application Support/Code/User/settings.json`

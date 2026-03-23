# Tools

CLI launcher scripts for GUI apps and developer tools. Everything in this folder gets symlinked to `~/.local/bin` by `install.sh`, making them available as commands in your terminal.

---

## Adding a Tool

Drop a launcher script here, make it executable, and re-run `install.sh` — or manually symlink it:

```bash
chmod +x tools/mytool
ln -sf "$PWD/tools/mytool" ~/.local/bin/mytool
```

---

## Getting Launchers for Common Tools

### IntelliJ IDEA
Go to **Tools → Create Command-line Launcher**, save the output as `tools/idea`.

### VS Code
Run `Cmd+Shift+P` → **"Shell Command: Install 'code' command in PATH"**, then copy the generated script:

```bash
cp /usr/local/bin/code tools/code
```

---

## Notes

- `README.md` is automatically excluded from symlinking by `install.sh`
- Scripts are made executable (`chmod +x`) automatically during install

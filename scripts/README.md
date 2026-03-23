# Scripts

Custom shell scripts for automating repetitive tasks. Scripts in `shell/` are made executable by `install.sh` automatically.

---

## Structure

```
scripts/
└── shell/      # shell scripts → made executable during install
```

---

## Adding a Script

1. Drop your script into `scripts/shell/`
2. Re-run `install.sh`, or manually make it executable:

```bash
chmod +x scripts/shell/your-script.sh
```

---

## Notes

- Scripts here are not symlinked to `~/.local/bin` — that's what the `tools/` folder is for
- If you want a script available as a global command, move or symlink it into `tools/` instead

# Git Config

Version-controlled git configuration files. All files in this folder are symlinked to your home directory by `install.sh`.

---

## Files

| File | Symlinked To | Purpose |
|------|-------------|---------|
| `gitconfig` | `~/.gitconfig` | Main git config — aliases, editor, default branch, etc. |
| `gitignore_global` | `~/.gitignore_global` | Global gitignore rules applied to every repo |
| `gitconfig-personal.inc` | `~/.gitconfig-personal.inc` | Personal identity (name, email) included by `.gitconfig` |

---

## Local Override

For machine-specific settings like work email, GPG signing key, or tokens, create `~/.gitconfig.local` — it is sourced automatically by `.gitconfig` if it exists:

```bash
# ~/.gitconfig.local
[user]
    email = <work-email>
    signingkey = <gpg-key-id>
```

This file is intentionally not committed to the repo.

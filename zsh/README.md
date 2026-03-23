# Zsh Config

Version-controlled zsh configuration files. All files in this folder are symlinked to their expected locations by `install.sh`.

---

## Files

| File | Symlinked To | Purpose |
|------|-------------|---------|
| `zshenv` | `~/.zshenv` | Loaded for every shell (interactive or not) — sets `$PATH` and core env vars |
| `zshrc` | `~/.zshrc` | Loaded for interactive shells — oh-my-zsh setup, plugins, prompt, sourcing |
| `alias.zsh` | `~/.oh-my-zsh/custom/alias.zsh` | Custom aliases — auto-loaded by oh-my-zsh from the `custom/` directory |

---

## Load Order

```
.zshenv → always loaded first
.zshrc  → loaded for interactive shells (after .zshenv)
alias.zsh → loaded by oh-my-zsh as part of .zshrc
```

---

## Local Override

For machine-specific env vars or aliases that shouldn't be committed, create `~/.zshrc.local` — it is sourced automatically by `.zshrc` if it exists:

```bash
# ~/.zshrc.local
export SOME_TOKEN="<value>"
alias work="cd ~/projects/work"
```

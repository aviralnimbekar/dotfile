# dotfiles

Personal macOS setup that bootstraps a new machine from scratch — installs packages, sets up shell config, and symlinks everything into place with a single script.

---

## Installation

Clone the repo and run the install script:

**HTTPS**
```bash
git clone https://github.com/<username>/dotfiles.git ~/dotfiles
```

**SSH**
```bash
git clone git@github.com:<username>/dotfiles.git ~/dotfiles
```

```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The script is idempotent — safe to run multiple times. It skips steps that are already done (e.g. won't reinstall Homebrew or oh-my-zsh if they exist).

---

## What the Installer Does

### 1. Homebrew
Installs Homebrew if not present, then runs `brew bundle` to install all packages and casks defined in the `Brewfile`.

### 2. oh-my-zsh
Installs oh-my-zsh in unattended mode if `~/.oh-my-zsh` doesn't already exist.

### 3. Symlinks
Creates symlinks from your home directory to the versioned files in this repo. This means any edits to config files are automatically tracked by git.

Symlinked configs include:
- `~/.gitconfig`, `~/.gitignore_global`, `~/.gitconfig-personal.inc`
- `~/.zshrc`, `~/.zshenv`
- `~/.oh-my-zsh/custom/alias.zsh`

### 4. Scripts & Tools
Makes all scripts in `scripts/shell/` executable. Symlinks everything in `tools/` to `~/.local/bin/` so they're available as CLI commands.

### 5. iTerm2
Configures iTerm2 to load its preferences from the `iterm/` folder in this repo, keeping your terminal setup version-controlled.

---

## Repository Structure

```
├── install.sh        # bootstrap entry point
├── Brewfile          # all Homebrew packages and casks
├── git/              # gitconfig, gitignore_global, gitconfig-personal.inc
├── zsh/              # zshrc, zshenv, alias.zsh
├── iterm/            # iTerm2 preferences
├── scripts/          # custom shell scripts
├── tools/            # CLI tools → symlinked to ~/.local/bin
└── macos/            # macOS system defaults
```

---

## Local Overrides

These files are machine-specific and intentionally not committed to the repo:

| File | Purpose |
|------|---------|
| `~/.gitconfig.local` | Work email, GPG signing key, tokens |
| `~/.zshrc.local` | Machine-specific env vars or aliases |

Create them manually as needed. They are sourced automatically if they exist.

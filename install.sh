#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "→ Starting dotfiles install..."

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "→ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -f "$DOTFILES/Brewfile" ]; then
  echo "→ Installing packages from Brewfile..."
  brew bundle --file="$DOTFILES/Brewfile"
fi

# --- oh-my-zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "→ Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Symlinks ---
echo "→ Creating symlinks..."

symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst" 2>/dev/null && echo "  linked $dst" || echo "  skipped $dst (already exists)"
}

symlink "$DOTFILES/git/gitconfig"              "$HOME/.gitconfig"
symlink "$DOTFILES/git/gitconfig-personal.inc" "$HOME/.gitconfig-personal.inc"
symlink "$DOTFILES/git/gitignore_global"       "$HOME/.gitignore_global"
symlink "$DOTFILES/zsh/zshrc"                  "$HOME/.zshrc"
symlink "$DOTFILES/zsh/zshenv"                 "$HOME/.zshenv"
symlink "$DOTFILES/zsh/alias.zsh"              "$HOME/.oh-my-zsh/custom/alias.zsh"

# Scripts — make shell scripts executable
chmod +x "$DOTFILES"/scripts/shell/*.sh 2>/dev/null

# Tools — symlink CLI launchers to ~/.local/bin
mkdir -p "$HOME/.local/bin"
for tool in "$DOTFILES/tools/"*; do
  [ -f "$tool" ] && [ "$(basename "$tool")" != "README.md" ] && \
    chmod +x "$tool" && \
    symlink "$tool" "$HOME/.local/bin/$(basename "$tool")"
done

# --- iTerm2 ---
if [ -d "$DOTFILES/iterm" ]; then
  echo "→ Configuring iTerm2 preferences path..."
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES/iterm"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
fi

# --- Directory Structure ---
echo "→ Creating project directories..."
mkdir -p "$HOME/projects/personal" "$HOME/projects/client"

# --- SDKMAN ---
bash "$DOTFILES/scripts/shell/install_sdkman.sh"

echo "✓ Done! Restart your terminal."

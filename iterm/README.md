# iTerm2 Preferences

This folder stores iTerm2's exported preferences as a `.plist` file, keeping your terminal setup version-controlled alongside the rest of your dotfiles.

---

## How It Works

The `install.sh` script configures iTerm2 to load its preferences from this directory automatically. Any changes you make in iTerm2 (colors, keybindings, profiles, etc.) can be saved back here and committed to git.

---

## Saving Your Settings

To export your current iTerm2 config into this folder:

1. Open iTerm2 → **Preferences** → **General** → **Preferences**
2. Check **"Load preferences from a custom folder or URL"**
3. Set the folder path to this directory
4. Click **"Save Current Settings to Folder"**

This generates `com.googlecode.iterm2.plist` in this directory.

---

## Notes

- Any time you change iTerm2 settings, re-save to this folder and commit the updated `.plist`
- On a new machine, `install.sh` handles pointing iTerm2 to this folder automatically — no manual steps needed

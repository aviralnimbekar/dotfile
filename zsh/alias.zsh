# Run backbone script for git or in general
alias rug="$DOTFILES/scripts/shell/run_all.sh git"
alias rua="$DOTFILES/scripts/shell/run_all.sh"
alias servicename="$DOTFILES/scripts/shell/get-all-repo-name.sh"
alias runapp="$DOTFILES/scripts/shell/runapp.sh"
alias prcopy="$DOTFILES/scripts/shell/copy-all-pr-url.sh $1"

# Git commands
alias gcln="$DOTFILES/scripts/shell/git-batch-processing.sh input.txt"
alias gco="git branch -a | fzf | sed 's#remotes/[^/]*/##' | xargs git checkout"

# Directory shortcuts
alias shelldir="cd $DOTFILES/scripts/shell"
alias pydir="cd $DOTFILES/scripts/python"
alias personaldir="cd ~/projects/personal"
alias shopdir="cd ~/projects/personal/shopizer"
alias admindir="cd ~/projects/personal/shopizer-admin"
alias reactdir="cd ~/projects/personal/shopizer-shop-reactjs"

# Docker
alias dcln="~/projects/personal/Scripts/shell/removecontainer.sh"
alias dps="docker ps -a --format '{{.ID}}\t {{.Names}}\t {{.Status}}\t'"

# Python
alias activatePy="source ~/projects/personal/Scripts/python/venv/bin/activate"

# JSON tools
json_pretty() {
  echo "$*" | jq
}

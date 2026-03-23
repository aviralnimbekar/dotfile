#!/bin/bash

print_usage() {
  echo "Usage:"
  echo -e "\t ./git-batch-processing.sh <file containing branches/tags> <action to perform>"
  echo -e "\t eg: ./git-batch-processing.sh example.txt print"
  echo -e "\t options available:"
  echo -e "\t\t print \n\t\t localBranchDelete \n\t\t tagDelete \n\t\t remoteBranchDelete"
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  echo "This file is use to run git command for multiple branches or tags for example deleteing multiple branches from local or remote"
  print_usage
  exit 0
fi

if [ $# != 2 ]; then
  print_usage
  exit 2
fi

# loading color code lib/script into this file
source /Users/aviralnimbekar/projects/personal/scripts/shell/color-code.sh

file=$1
action=$2

# Main function to run the loop
run_loop_with_cmd() {
  enable_bright_cyan_text_color
  echo "Filtering master, main, gh-pages, current branch, v1.0.0..."
  enable_normal_text_color

  file_updated=$(grep -v '\*\|main\|master\|gh-pages\|v1.0.0' "$file")

  for line in ${file_updated}; do
    $1 ${line}
  done
}

if [ "$action" == "print" ]; then
  run_loop_with_cmd 'echo -e'
fi

if [ "$action" == "localBranchDelete" ]; then
  run_loop_with_cmd 'git branch -D'
fi

if [ "$action" == "remoteBranchDelete" ]; then
    run_loop_with_cmd 'git push -d --no-verify origin'
fi

if [ "$action" == "tagDelete" ]; then
#  run_loop_with_cmd 'git push -d --no-verify origin'
# this will delete from both local and remote
  run_loop_with_cmd 'git delete-tag'
fi

# -n1: This tells read to read only one character of input without waiting for the user to press Enter.
read -n1 -p "Do you want to delete $file (y/n) : " input
echo ""

if [ "$input" == "y" ]; then
  enable_bright_yellow_text_color
  echo "Deleting $file ..."
  enable_normal_text_color
  rm "$file"
fi

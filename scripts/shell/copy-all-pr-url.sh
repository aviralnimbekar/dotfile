#!/bin/bash 

if [ "$1" = "-h" ]; then
  echo "This script will get all the PR link raised in checkedout branch and copy to clipboard"
  echo ""
  echo "For eg:"
  echo -e "\t FOLDER=personal MINDEPTH=2 copy-all-pr-url.sh"
  exit 1
fi

# loading color code lib/script into this file
source /Users/aviralnimbekar/projects/personal/scripts/shell/color-code.sh

MINDEPTH=${MINDEPTH:-1}
MAXDEPTH=${MAXDEPTH:-3}
FOLDER=${FOLDER:-.}
FILTER=${FILTER:-"$1"}

PYTHON_SCRIPT=${HOME}/projects/personal/scripts/python/update-pr-urls-file.py
PR_URLS_FILE=${HOME}/projects/jd/pr-urls.txt

date

enable_bright_yellow_text_color
echo "Finding git repos starting in folder '${FOLDER}' for a min depth of ${MINDEPTH} and max depth of ${MAXDEPTH}"
if [ "${FILTER}" != "" ]; then
  echo "Filtering with: ${FILTER}"
fi
enable_normal_text_color

# TODO: Tried to use -regex to filter out folders, but "run from any direcctory for any combination of FILTER and FOLDER is not working"
# \( ! -regex "${HOME}/.git" \) \( ! -regex "${HOME}/Library/.git" \) \( ! -regex "${HOME}/.vscode/.git" \) \( ! -regex "${HOME}/tmp/.git" \)
DIRECTORIES=$(find "${FOLDER}" -mindepth "${MINDEPTH}" -maxdepth "${MAXDEPTH}" -name ".git" -type d -exec dirname {} \; 2>/dev/null | grep -iE "${FILTER}" | sort)

# I have some special repos that should not show up in this list for processing - removing them
if [[ "${FOLDER}" == "." ]] && [[ "$PWD" == "${HOME}" ]] || [[ "${FOLDER}" == "${HOME}" ]]; then
  # Note: This line will remove my repo in '~' folder
  # DIRECTORIES=$(echo "${DIRECTORIES}" | sed -E "s|^${HOME}$||" | sed -E "s|^${HOME}\/$||")
  # Note: This line will remove any entry with 'tmp' or 'Library/Cache' in the path
  DIRECTORIES=$(echo "${DIRECTORIES}" | grep -v -e tmp -e "Library/Cache")
fi

all_prs=""
current_dir="$(pwd)"

TOTAL_COUNT=$(echo "${DIRECTORIES}" | wc -w)
COUNT=1
for dir in ${DIRECTORIES}; do
  if [ -d "$dir" ] && [ ! -h "$dir" ]; then
    enable_bright_cyan_text_color
    repo_name=$(basename "$dir")
    echo ">>>>>>>>>>>>>>>>>>>>> [${COUNT} of ${TOTAL_COUNT}] 'gh pr view' (in '$repo_name') <<<<<<<<<<<<<<<<<<<<"
    enable_normal_text_color

    cd $dir
    pr_data="$(gh pr view --json title,url)"
    all_prs+="${pr_data}\n"
    cd $current_dir
    COUNT=$((COUNT + 1))
  fi
done

# move back to initial working dir
cd "$current_dir"

echo -e ${all_prs} | jq -r '"\(.title) \n=> \(.url)"' | pbcopy
enable_bright_yellow_text_color
echo "urls copied to clipboard"
enable_normal_text_color

date

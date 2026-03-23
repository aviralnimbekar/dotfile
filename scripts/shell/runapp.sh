#!/bin/bash

print_usage() {
	echo "Usage:"
	echo -e "\t runapp.sh <Name of the service>"
	echo -e "\t eg: runapp.sh shipping"
	echo -e "\t options available:"
	echo -e "\t\t shipping \n\t\t  dealer \n\t\t  pai"
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	echo "This file is use to run pre-checkout app locally by spinning up required dependencies"
	print_usage
	exit 0
fi

if [ $# != 1 ]; then
	print_usage
	exit 2
fi

# loading color code lib/script into this file
source /Users/aviralnimbekar/projects/personal/scripts/shell/color-code.sh

# Provide value of folder location where all java code are checked out
PRE_CHECKOUT_PATH="${HOME}"/projects/jd/pre-checkout
POST_CHECKOUT_PATH="${HOME}"/projects/jd/post-checkout
PERSONAL="${HOME}"/projects/personal

# Takes service name from user
service=$1

if [[ "$service" == "slack" ]]; then
#	enable_bright_cyan_text_color
	docker-compose -f "${SLACK_PATH}"/slack-clone-2.0/docker-compose.yml up -d
#	enable_normal_text_color
fi

echo ""
docker ps -a --format "table {{.Names}}\t{{.ID}}\t{{.Status}}"
echo docker ps -a --format \"table {{.Names}}"\\\t"{{.ID}}"\\\t"{{.Status}}\" | pbcopy

#!/bin/bash

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "Usage: removecontainer.sh OR removecontainer.sh images"
    echo -e "\t No args present         - Stop and remove all running containers"
    echo -e "\t images as arg present   - Remove all docker images"
    exit 0
fi

# loading color code lib/script into this file
source /Users/aviralnimbekar/projects/personal/scripts/shell/color-code.sh

if [ "$1" == "images" ]; then
    enable_bright_yellow_text_color
    echo "Running docker rmi..."
    enable_normal_text_color

    docker rmi $(docker images -q)
else
    enable_bright_yellow_text_color
    echo "Running docker stop..."
    enable_normal_text_color

    docker stop $(docker ps -aq)

    enable_bright_yellow_text_color
    echo "Running docker rm..."
    enable_normal_text_color

    docker rm $(docker ps -a --format "{{.Names}}")
fi

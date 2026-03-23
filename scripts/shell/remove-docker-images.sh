#!/bin/bash

file=$1

while read -r line;
do
  docker rmi "$line"
done < "$file"

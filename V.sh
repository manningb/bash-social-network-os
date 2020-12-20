#!/bin/bash
# V.sh
# unlocks a file

if [ ! $# -eq 1 ]; then
	echo "usage: $0 locked_file"
	exit 1
else
	if [ -e "$1-lock.sh" ]; then
		rm "$1-lock.sh"
		exit 0
	else
		echo "$1-lock.sh" does not exist
		exit 2
	fi
fi 

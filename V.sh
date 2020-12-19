#!/bin/bash
# V.sh
# unlocks a file

if [ ! $# -eq 1 ]; then
	echo "usage: $0 locked_file"
	exit 1
else
	if [ -f "$1_lock.sh" ]; then
		rm "$1_lock.sh"
		exit 0
	else
		echo "$1_lock.sh" does not exist
		exit 2
	fi
fi 

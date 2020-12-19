#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "usage: $0 locked_file"
else
	if [ -f "$1_lock.sh" ]; then
		rm "$1_lock.sh"
	else
		echo "$1_lock.sh" does not exist
	fi
fi 

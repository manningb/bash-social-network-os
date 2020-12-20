#!/bin/bash
# P.sh
# locks a file

if [ ! $# -eq 1 ]; then
	echo "Usage $0 file_to_lock"
	exit 1
elif [ ! -e "$0" ]; then
	echo "File to be locked must exit"
	exit 2
else
	while ! ln "$0" "$1-lock.sh" 2> /dev/null;
		do
			sleep 0
		done
		exit 0
fi 

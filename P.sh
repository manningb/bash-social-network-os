#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "Usage $0 file_to_lock"
	exit 1
elif [ ! -e "$1" ]; then
	echo "File to be locked must exit"
	exit 2
else
	while ! ln "$1" "$1_lock.sh" 2> /dev/null ; 
		do
			echo $0
			sleep 1
		done
		exit 0
fi 

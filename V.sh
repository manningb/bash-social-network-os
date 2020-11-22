#!/bin/bash

if [ $# -eq 2 ]; then
	if [ -f "$1/lock.sh" ]; then
		rm "$1/lock.sh"
	else
		echo "$1" does not exist
	fi
elif [ $# -eq 1 ]; then
	if [ -f "lock.sh" ]; then
		rm "lock.sh"
	else
		echo "lock.sh" does not exist
	fi
else
	echo Please enter only one arguement
fi 

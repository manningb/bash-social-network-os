#!/bin/bash

if [ $# -eq 2 ]; then
	if [ -f "users/$1/lock.sh" ]; then
		rm "users/$1/lock.sh"
	else
		echo "$1" does not exist
	fi
elif [ $# -eq 1 ]; then
	if [ -f "users/lock.sh" ]; then
		rm "users/lock.sh"
	else
		echo "users/lock.sh" does not exist
	fi
else
	echo Please enter only one arguement
fi 

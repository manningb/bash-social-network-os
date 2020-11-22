#!/bin/bash

if [ $# -eq 2 ]; then
	while ! ln "$1/$2" "$1/lock.sh" > /dev/null ; 
		do
			sleep 0
		done
elif [ $# -eq 1 ]; then
	while ! ln "$0" "lock.sh" > /dev/null ; 
		do
			sleep 0
		done
else
	echo Please enter only one arguement
fi 

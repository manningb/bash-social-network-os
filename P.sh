#!/bin/bash

if [ $# -eq 2 ]; then
	while ! ln "$1/$2" "$1/lock.sh" > /dev/null ; 
		do
			sleep 0
		done
		exit 0
elif [ $# -eq 1 ]; then
	while ! ln "$1" "$1_lock.sh" 2> /dev/null ; 
		do
			echo $0
			sleep 1
		done
		exit 0
else
	echo Error: Please enter either one or two arguments
	exit 1
fi 

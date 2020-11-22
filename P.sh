#!/bin/bash

if [ $# -eq 2 ]; then
	while ! ln "users/$1/$2" "users/$1/lock.sh" > /dev/null ; 
		do
			sleep 1
		done
elif [ $# -eq 1 ]; then
	while ! ln "$0" "users/lock.sh" > /dev/null ; 
		do
			sleep 1
		done
else
	echo Please enter only one arguement
fi 

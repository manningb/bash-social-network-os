#!/bin/bash

while [ "$1" != "shutdown" ]; do
	echo true
	case "$request" in 
		create)
			./create.sh $request
			;;
	esac
done

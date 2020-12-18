#!/bin/bash

if [ "$#" -lt 2 ]; then
	echo "Error: This script requires at least two arguments"
	echo "usage: $0 clientid req [*args]"
	exit 1
elif [ -e "$1.pipe" ]; then
	echo "Error: Client in use"
	exit 1
else
	
	mkfifo "$1.pipe"
	trap "rm $1.pipe" EXIT
	echo "$@" > server.pipe
	while read input; do
	       echo "$input"	
	done < "$1.pipe"
	exit 0
fi

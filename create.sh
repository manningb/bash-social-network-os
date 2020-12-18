#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "Error: This scripts requires 1 argument" >&2
	echo "usage: $0 user"
	exit 1
elif [ -d "$1" ]; then
	echo "Error: User $1 already created." >&2
	exit 1 
fi
echo $1 $2
./P.sh "create.sh"
mkdir "$1"
touch "$1/wall" "$1/friends"
echo "OK: User folder and files created for $1"
./V.sh "create.sh"
exit 0

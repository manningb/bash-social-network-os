#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "This scripts requires 1 argument" >&2
	echo "usage: $0 user"
	exit 1
elif [ -d "$1" ]; then
	echo "User $1 already created." >&2
	exit 1 
fi
./P.sh "$1"
mkdir "$1"
touch "$1/wall" "$1/friends"
echo "User folder and files created for $1"
./V.sh "$1"
exit 0

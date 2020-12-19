#!/bin/bash

user="$1"

if [ ! $# -eq 1 ]; then
	echo "Error: This scripts requires 1 argument" >&2
	echo "usage: $0 user"
	exit 1
elif [ -d "$user" ]; then
	echo "Error: User $user already created." >&2
	exit 1 
fi

./P.sh "create.sh"
mkdir "$user"
touch "$user/wall" "$user/friends"
echo "OK: User folder and files created for $user"
./V.sh "create.sh"
exit 0

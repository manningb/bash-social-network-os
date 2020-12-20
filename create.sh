#!/bin/bash
# create.sh
# creates a new user and their wall and friends files

user="$1"

if [ ! $# -eq 1 ]; then
	echo "Error: This scripts requires 1 argument" >&2
	echo "usage: $0 user"
	exit 1
fi

./P.sh "$user-create"
if [ -d "$user" ]; then
	echo "Error: User $user already created." >&2
	./V.sh "$user-create"
	exit 2
fi
./V.sh "$user-create"

mkdir "$user"
touch "$user/wall" "$user/friends"
echo "OK: User folder and files created for $user"

exit 0

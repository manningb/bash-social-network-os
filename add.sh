#!/bin/bash
# add.sh

user="$1"
friend="$2"

if [ ! $# -eq 2 ]; then
        echo "Error: This script requires 2 arguments" >&2
        echo "usage: $0 user friend" >&2
        exit 1
elif [ ! -e "$user" ]; then
	echo "Error: User $user does not exist" >&2
	exit 1
elif [ ! -e "$friend" ]; then
	echo "Error: Friend $friend does not exist" >&2
	exit 1
fi

while read -r user_friend; do
	if [ "$user_friend" == "$friend" ]; then
		echo "Error: $friend is already a friend of $user" >&2
		exit 1
	fi
done <"$user/friends"

./P.sh "$user/friends"
echo "$friend" >>"$user/friends" >&1
echo "OK: $friend added as friend of user $user"
./V.sh "$user/friends"

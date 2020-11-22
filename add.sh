#!/bin/bash

if [ ! $# -eq 2 ]; then
        echo "This script requires 2 arguments" >&2
        echo "usage: $0 user friend" >&2
        exit 1
elif [ ! -e "users/$1" ]; then
	echo "User $1 does not exist" >&2
	exit 1
elif [ ! -e "users/$2" ]; then
	echo "Friend $2 does not exist" >&2
	exit 1
fi

while read friend; do
	if [ "$friend" == "$2" ]; then
		echo "$2 is already a friend of $1" >&2
		exit 1
	fi
done <"users/$1/friends"
./P.sh "$1"
echo "$2" >>"users/$1/friends" >&1
echo "$2 added as friend of user $1"
sleep 5
./V.sh "$1"

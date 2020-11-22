#!/bin/bash

##check arguments
if [ ! $# -eq 3 ]; then
        echo "This script requires 3 arguments" >&2
        echo "usage: $0 receiver sender message" >&2
        exit 1
elif [ ! -e "users/$1" ]; then
        echo "Receiver $1 not found" >&2
        exit 1
elif [ ! -e "users/$2" ]; then
        echo "Sender $2 not found" >&2
        exit 1
fi

while read friend; do
        if [ "$friend" == "$2" ]; then
		./P.sh "$1"
		datetime=$(date +"%Y-%m-%d %T")	
		echo "$datetime - $2 : $3" >> "users/$1/wall" >&1
		echo Message "$3" sent to "$1" from "$2"! >&1
		sleep 5
		./V.sh "$1"
                exit 0
        fi
done <"users/$1/friends"

echo "$2" is not a friend of "$1" so the message "$3" was not posted >&2
exit 1

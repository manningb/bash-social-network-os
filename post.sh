#!/bin/bash

##check arguments
if [ $# -lt 3 ]; then
        echo "Error: This script requires 3 arguments" >&2
        echo "usage: $0 receiver sender message" >&2
        exit 1
elif [ ! -e "$1" ]; then
        echo "Error: Receiver $1 not found" >&2
        exit 1
elif [ ! -e "$2" ]; then
        echo "Error: Sender $2 not found" >&2
        exit 1
fi

while read friend; do
        if [ "$friend" == "$2" ]; then
		./P.sh "$1/wall"
		echo "$2: ${@:3}" >> "$1/wall" >&1
		echo OK: Message "${@:3}" sent to "$1" from "$2"! >&1
		sleep 5
		./V.sh "$1/wall"
                exit 0
        fi
done <"$1/friends"

echo "Error: $2 is not a friend of $1 so the message $3 was not posted" >&2
exit 1

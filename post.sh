#!/bin/bash
# post.sh
# posts a message to a users wall from another user

receiver="$1"
sender="$2"
message="${*:3}"

##check arguments
if [ $# -lt 3 ]; then
        echo "Error: This script requires 3 arguments" >&2
        echo "usage: $0 receiver sender message" >&2
        exit 1
elif [ ! -e "$receiver" ]; then
        echo "Error: Receiver $receiver not found" >&2
        exit 2
elif [ ! -e "$sender" ]; then
        echo "Error: Sender $sender not found" >&2
        exit 2
fi

while read -r friend; do
        if [ "$friend" == "$sender" ]; then
		./P.sh "$receiver/wall"
		echo "$sender: $message" >> "$receiver/wall" >&1
		echo OK: Message "$message" sent to "$receiver" from "$sender"! >&1
		./V.sh "$receiver/wall"
                exit 0
        fi
done <"$receiver/friends"

echo "Error: $sender is not a friend of $receiver so the message $message was not posted" >&2
exit 1

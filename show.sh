#!/bin/bash

if [ ! $# -eq 1 ]; then
        echo "This script requires 1 argument" >&2
        echo "usage: $0 user" >&2
        exit 1
elif [ ! -e "$1" ]; then
        echo "User $1 not found" >&2
        exit 1
fi

echo "wallStart"
while read post; do
	echo "$post"
done <"$1/wall"
echo "wallEnd"
exit 0

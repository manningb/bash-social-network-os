#!/bin/bash
# show.sh
# shows all the posts on a user's wall

user="$1"

if [ ! $# -eq 1 ]; then
        echo "Error: This script requires 1 argument" >&2
        echo "usage: $0 user" >&2
        exit 1
elif [ ! -e "$user" ]; then
        echo "Error: User $user not found" >&2
        exit 2
fi

echo "wallStart"
while read -r post; do
	echo "$post"
done <"$user/wall"
echo "wallEnd"
exit 0

#!/bin/bash

client="$1"
request="$@"

if [ "$#" -lt 3 ]; then
	echo "Error: This script requires at least three arguments"
	echo "usage: $0 clientid req [*args]"
	exit 1
elif [ ! -e "server.pipe" ]; then
	echo "Error: Server is not started"
	exit 1
elif [ -e "$client.pipe" ]; then
	echo "Error: Client in use"
	exit 1
else
	mkfifo "$client.pipe"
	echo "$request" > server.pipe
	while read -r input; do
	       echo "$input"	
	done < "$client.pipe"
	rm "$client.pipe"
	exit 0
fi

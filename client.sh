#!/bin/bash
# client.sh
# passes requests to the server and returns the output

client="$1"
request="$2"
full_request="$@"

if [ "$#" -lt 2 ]; then
	echo "Error: This script requires at least two arguments"
	echo "usage: $0 clientid req [*args]"
	exit 1
elif [ ! -e "server.pipe" ]; then
	echo "Error: Server is not started"
	exit 2
elif [ -e "$client.pipe" ]; then
	echo "Error: Client in use"
	exit 2
else
	case "$request" in
		create)
			if [ ! "$#" -eq 3 ]; then
				echo "Error: This request requires one argument"
				echo "usage: $0 clientid $request user"
				exit 1
			fi
			;;
			add)
			if [ ! "$#" -eq 4 ]; then
				echo "Error: This request requires two arguments"
				echo "usage: $0 clientid $request user friend"
				exit 1
			fi
		        ;;	
			post)
			if [ ! "$#" -lt 4 ]; then
				echo "Error: This request requires three arguments"
				echo "usage: $0 clientid $request recevier sender message"
				exit 1
			fi
		        ;;	
			show)
			if [ ! "$#" -eq 3 ]; then
				echo "Error: This request requires one argument"
				echo "usage: $0 clientid $request user"
				exit 1
			fi
		        ;;	
			shutdown)
			if [ ! "$#" -eq 2 ]; then
				echo "Error: This request requires 0 arguments"
				echo "usage: $0 clientid $request"
				exit 1
			fi
			;;
			*)
			echo "Error: bad request"
			exit 1
			;;
	esac

	mkfifo "$client.pipe"
	echo "$full_request" > server.pipe
	while read -r input; do
		echo "$input"	
	done < "$client.pipe"
	rm "$client.pipe"
	exit 0
fi

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
fi

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
		if [ "$#" -lt 4 ]; then
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

./P.sh "$client"
if [ -e "$client.pipe" ]; then
        echo "Error: Client $client in use"
	./V.sh "$client"
	exit 2
else
	mkfifo "$client.pipe"
fi
./V.sh "$client"

echo "$full_request" >> server.pipe

while read -r input; do
	echo "$input"	
done < "$client.pipe"
rm "$client.pipe"
exit 0

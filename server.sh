#!/bin/bash

while true; do
	read input
	input=($input)
	request=${input[0]}
	case "$request" in
		create)
			./create.sh ${input[1]}
			# do something 
			;;
		add)
			./add.sh ${input[1]} ${input[2]}
			# do something 
			;;
		post)
			./post.sh ${input[1]} ${input[2]} ${input[3]}
			# do something 
			;;
		show)
			./show.sh ${input[1]}
			# do something
			;;
		shutdown)
			echo "Shutting down server.."
			exit 0
			# do something 
			;;
		*)
			echo "Error: bad request"
			exit 1
	esac
done

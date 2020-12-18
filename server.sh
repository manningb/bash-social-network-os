#!/bin/bash

mkfifo server.pipe
trap "rm server.pipe" EXIT #always remove server.pipe on EXIT
while true; do
        read -r input < server.pipe
	input=($input) #convert input to array
	client_pipe="${input[0]}.pipe"
        request="${input[1]}" 
	 case "$request" in
                create)
                        ./create.sh "${input[2]}" &> "$client_pipe" & sleep 1
                        ;;
                add)
                        ./add.sh "${input[2]}" "${input[3]}" &> "$client_pipe" & sleep 1 
                        ;;
                post)
                        ./post.sh "${input[2]}" "${input[3]}" "${input[@]:4}" &> "$client_pipe" & sleep 1
			;;
                show)
                        ./show.sh "${input[2]}" &> "$client_pipe" & sleep 1
			;;
                shutdown)
                        echo "Shutting down server.." &> "$client_pipe"  & sleep 1
                        exit 0
                        ;;
                *)
                        echo "Error: bad request" &> "$client_pipe" & sleep 1
                        #exit 1
        esac
done

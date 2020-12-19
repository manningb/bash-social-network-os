#!/bin/bash
# server.sh
# takes requests from clients are returns the output

if [ -e server.pipe ]; then
        echo server is already in use
        exit 1
else
    mkfifo server.pipe
    trap "rm server.pipe" EXIT #always remove server.pipe on EXIT
    while true; do
            read -ra input < server.pipe
	    client_pipe="${input[0]}.pipe"
	    request="${input[1]}"
	    user="${input[2]}"
            case "$request" in
                    create)
                            ./create.sh "$user" &> "$client_pipe" & sleep 1
                            ;;
                    add)
                            ./add.sh "$user" "${input[3]}" &> "$client_pipe" & sleep 1
                            ;;
                    post)
                            ./post.sh "$user" "${input[3]}" "${input[@]:4}" &> "$client_pipe" & sleep 1
                            ;;
                    show)
                            ./show.sh "$user" &> "$client_pipe" & sleep 1
                            ;;
                    shutdown)
                            echo "Shutting down server.." &> "$client_pipe"  & sleep 1
                            exit 0
                            ;;
                    *)
                            echo "Error: bad request" &> "$client_pipe" & sleep 1
            esac
    done
fi

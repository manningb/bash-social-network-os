#!/bin/bash

if [ $# < 3 ]; then
	echo "This script requires at least three arguments"
	echo "usage: $0 clientid req [args]"
fi

clientid="$1"
request="$2"


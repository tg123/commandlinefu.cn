#!/bin/bash

FILE=$1

if [ "$FILE" == "" ]; then
    exit
fi

COMMANDLINEFU_ID=`grep 'commandlinefu_id:'  $FILE | sed 's/commandlinefu_id:\ *//g'`

URL="http://www.commandlinefu.com/commands/collection/${COMMANDLINEFU_ID}/json"

JSON=`curl -s $URL`

echo "$JSON" | grep -Po "vote.*\d\"" | grep -Po "\-?\d+"

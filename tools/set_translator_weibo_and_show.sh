#!/bin/bash

BASEDIR=$(dirname $(readlink -f $0)) 

TRANSLATOR_WEIBO=''
TO_REPLACE=''

# if no arguments and weibo.conf exits
if [ $# -eq 0 -a -f $BASEDIR/weibo.conf ]; then
	TRANSLATOR_WEIBO=`cat $BASEDIR/weibo.conf`
else
	TRANSLATOR_WEIBO=$1
	TO_REPLACE=${2:-"''"}
fi

if [ -z $TRANSLATOR_WEIBO ];then

    echo "Usage: $0 [TRANSLATOR_WEIBO]"
	echo "You can ignore TRANSLATOR_WEIBO if your weibo_id is kept in tools/weibo.conf"
    exit;
fi


DATADIR="$BASEDIR/../_data"

LIST=`git status -s $DATADIR | grep "^ ?M" -P | cut -d ' ' -f 3`

for f in $LIST;do
    if [ -f $f ]; then
        echo "SET $f Translator WEIBO to $TRANSLATOR_WEIBO"
        sed -i "s/weibo: $TO_REPLACE\$/weibo: $TRANSLATOR_WEIBO/g" $f
        sed -i "/^hide: true$/d" $f
    fi
done

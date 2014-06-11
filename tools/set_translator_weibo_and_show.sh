#!/bin/bash

TRANSLATOR_WEIBO=$1
TO_REPLACE=${2:-"''"}


if [ -z $TRANSLATOR_WEIBO ];then

    echo "Usage: $0 TRANSLATOR_WEIBO"
    exit;
fi


BASEDIR=$(dirname $(readlink -f $0)) 
DATADIR="$BASEDIR/../_data"

LIST=`git status -s $DATADIR | grep "^ ?M" -P | cut -d ' ' -f 3`

for f in $LIST;do
    if [ -f $f ]; then
        echo "SET $f Translator WEIBO to $TRANSLATOR_WEIBO"
        sed -i "s/weibo: $TO_REPLACE\$/weibo: $TRANSLATOR_WEIBO/g" $f
        sed -i "/^hide: true$/d" $f
    fi
done

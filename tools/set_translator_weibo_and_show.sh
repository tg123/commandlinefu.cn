#!/bin/bash

TRANSLATOR_WEIBO=''
TO_REPLACE="''"

# import the global variable such as $CONFIG
if [[ -n $(pwd | grep 'tools$')  ]]; then
    . ./config.sh
else
    . ./tools/config.sh
fi

# if no arguments and weibo.conf exits
if [ $# -eq 0 -a -f "$CONFIG" ]; then
    TRANSLATOR_WEIBO=`head -1 "$CONFIG"`
else
    TRANSLATOR_WEIBO=$1
    TO_REPLACE=${2:-"''"}

    # create .commandlinefu for future need
    if [ ! -d $HOME/.commandlinefu ];then
        mkdir $HOME/.commandlinefu
    fi
fi

if [ -z "$TRANSLATOR_WEIBO" ];then
    echo "please input your weibo username as the name of contributor:"
    read TRANSLATOR_WEIBO
    echo "$TRANSLATOR_WEIBO" > "$CONFIG"
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

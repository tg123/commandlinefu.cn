#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
	BASEDIR=$(dirname $0)
else
	BASEDIR=$(dirname $(readlink -f $0))
fi

DATADIR="$BASEDIR/../_data"

#a=(`grep "hide: true" $DATADIR -rl`)
a=(`ls $DATADIR`)

total=${#a[@]}

c=$((RANDOM%total))

while true; do
    target=${a[c]}
    if [ -n `grep "hide: true" $target` ];then
        $EDITOR $DATADIR/$target
        break
    fi
    c=$((c+1))
    c=$((c%total))
done

#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
	BASEDIR=$(dirname $0)
else
	BASEDIR=$(dirname $(readlink -f $0))
fi

DATADIR="$BASEDIR/../_data"

a=(`grep "hide: true" $DATADIR -rl`)

total=${#a[@]}

c=$((RANDOM%total))

if ! (($EDITOR))
then
    EDITOR='nano'
fi

$EDITOR ${a[c]}

#!/bin/bash


BASEDIR=$(dirname $(readlink -f $0)) 

DATADIR="$BASEDIR/../_data"

a=(`grep "hide: true" $DATADIR -rl`)

total=${#a[@]}

c=$((RANDOM%total))

if ! (($EDITOR))
then
    EDITOR='nano'
fi

$EDITOR ${a[c]}

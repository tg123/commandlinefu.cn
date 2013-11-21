#!/bin/bash


BASEDIR=$(dirname $(readlink -f $0)) 

DATADIR="$BASEDIR/../_data"

a=(`grep "hide: true" $DATADIR -rl`)

total=${#a[@]}

c=$((RANDOM%total))

$EDITOR ${a[c]}

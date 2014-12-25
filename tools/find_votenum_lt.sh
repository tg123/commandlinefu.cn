#!/bin/bash

# bsd coreutils is not support yet

BASEDIR=$(dirname $(readlink -f $0))

VOTE_BIN="$BASEDIR/votenum.sh"

DATADIR="$BASEDIR/../_data"

for i in $DATADIR/*.yaml ; do

    v=`$VOTE_BIN $i`

    if [ $v -lt 0 ]; then
        echo $i $v
    fi

done

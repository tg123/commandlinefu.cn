#!/bin/bash

TRANSLATOR_WEIBO=$1

if [ -z $TRANSLATOR_WEIBO ];then

    echo "Usage: $0 TRANSLATOR_WEIBO"
    exit;
fi

SCRIPTDIR=`(cd \`dirname $0\`; pwd)`
BASEDIR=$(dirname $SCRIPTDIR)
DATADIR="$BASEDIR/_data"

LIST=`git --work-tree "$BASEDIR" --git-dir "${BASEDIR}/.git" status -s $DATADIR | grep -e '^ M' | cut -d ' ' -f 3`

for f in $LIST;do
    absolute_file_path=$DATADIR/${f##*/}
    echo $absolute_file_path
    if [ -f $absolute_file_path ]; then
        echo "SET $f Translator WEIBO to $TRANSLATOR_WEIBO"
        sed -i '' "s/weibo: ''/weibo: $TRANSLATOR_WEIBO/g" $absolute_file_path
        sed -i '' "/^hide: true$/d" $absolute_file_path
    fi
done

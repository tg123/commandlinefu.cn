#!/bin/bash

if [[ -n $(pwd | grep 'tools$')  ]]; then
    cd .. # cd to the root directory
fi

# if nothing to commit
if [ -z "$(git status)" ]; then
    exit
fi

# current directory will be the root directory
# import the global variable such as $GIT_CONFIG
. tools/config.sh

./tools/set_translator_weibo_and_show.sh
echo 'Press RETURN to commit your translation or use CTRL-C to leave'
read # stop here and read the RETURN

# if COMMIT_DATA_CHANGE is ALL: git add all change
# else: git add Modified files
DEFAULT_COMMIT_SETTING="COMMIT_DATA_CHANGE=ALL"
if [ -f "$GIT_CONFIG" ]; then
    . "$GIT_CONFIG"
else
    echo "$DEFAULT_COMMIT_SETTING" > "$GIT_CONFIG"
fi

if [ "${COMMIT_DATA_CHANGE=ALL}" == "ALL" ]; then
    git add -A _data/
else
    git add _data/
fi
git commit 


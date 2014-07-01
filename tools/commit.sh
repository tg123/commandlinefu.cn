#!/bin/bash

if [[ -n $(pwd | grep 'tools$')  ]]; then
    cd .. # cd to the root directory
fi

# if nothing to commit
if [ -z "$(git status)" ]; then
    exit
fi

# current directory will be the root directory
# import the global variable such as $CONFIG
. tools/config.sh

./tools/set_translator_weibo_and_show.sh
git add _data/
git commit 


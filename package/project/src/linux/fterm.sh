#!/bin/bash
# Script will start docker

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run docker shell within current dirrectory
echo "- Home directory mounted to '$HOME'"
if [ -f "$CWD/.inject.sh" ]; then
    source "$CWD/.inject.sh"
fi


# if no argument was supplied open shell
if [ -z "$1" ]
  then
    docker run -ti --rm -v "/$HOME:/$HOME" $EXTRA_MOUNT -w "/$(pwd)" -u $(id -u):$(id -g) "@IMAGE_TAG@:user" bash -l
else
    echo "Executing $@"
    docker run -ti --rm -v "/$HOME:/$HOME" $EXTRA_MOUNT -w "/$(pwd)" -u $(id -u):$(id -g) "@IMAGE_TAG@:user" "$@"
fi

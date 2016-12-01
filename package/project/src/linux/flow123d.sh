#!/bin/bash
# Script will run flow123d with given parameters

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run docker shell within current dirrectory
docker run -ti --rm -w //cwd -v "/$(pwd)://cwd" -u $(id -u):$(id -g) "@IMAGE_TAG@:user" /opt/flow123d/flow123d/bin/flow123d "$@"
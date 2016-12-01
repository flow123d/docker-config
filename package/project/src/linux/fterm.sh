#!/bin/bash
# Script will start docker

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run docker shell within current dirrectory
docker run -ti --rm -w //cwd -v "/$(pwd)://cwd" -u $(id -u):$(id -g) "@IMAGE_TAG@:user" bash -l
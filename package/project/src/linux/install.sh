#!/bin/bash
# Script will import docker image into system

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# get image path and import into to machine
echo "Importing docker image '@IMAGE_TAG@'"
IMAGE_PATH=$CWD/data/@IMAGE_NAME@
docker import $IMAGE_PATH @IMAGE_TAG@

# run configure on this image to personalise the image
echo "Modifying docker image '@IMAGE_TAG@'"
IMAGE_TAG="@IMAGE_TAG@"
IMAGE_TAG=${IMAGE_TAG#flow123d/}
export IMAGE_TAG=${IMAGE_TAG}
$CWD/bin/configure --skip-build --images "@IMAGE_TAG@"

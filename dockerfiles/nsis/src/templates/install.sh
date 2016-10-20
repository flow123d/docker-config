#!/bin/bash

# 1st argument: path to bash
# 2nd argument: path to install dir

echo "=========================================================="
echo "Testing docker env"
echo "----------------------------------------------------------"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
pwd
whoami


echo "=========================================================="
echo "Importing image"
echo "----------------------------------------------------------"
docker import "../libs/flow123d-image.tar.gz" @IMAGE_NAME@
docker images


echo "=========================================================="
echo "Running ./configure"
./configure -s -y -i "@IMAGE_NAME@"


echo "=========================================================="
echo "Creating shortcut"
echo "----------------------------------------------------------"
cat > flow123d.bat << EOL
@echo off
start "Flow123d" "$1" "$2\run.sh"
EOL
echo "=========================================================="

#!/bin/bash

# 1st argument: path to bash
# 2nd argument: path to install dir


# fterm.bat shortcut
echo "=========================================================="
echo "Creating fterm.bat shortcut"
echo "----------------------------------------------------------"
cat > bin/fterm.bat << EOL
@echo off
docker-machine start default
@FOR /f "tokens=*" %%i IN ('docker-machine env') DO @%%i
start "Fterm" "$1" "$2\bin\fterm.sh"
EOL


# flow123d.bat shortcut
echo "=========================================================="
echo "Creating flow123d.bat shortcut"
echo "----------------------------------------------------------"
cat > bin/flow123d.bat << EOL
@echo off
docker-machine start default
@FOR /f "tokens=*" %%i IN ('docker-machine env') DO @%%i
start "Flow123d" "$1" "$2\bin\flow123d.sh"
EOL
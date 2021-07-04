#!/bin/bash
# install mpich on Charon

module add gcc-8.3.0
module add opa-psm2/opa-psm2-11.2.77-gcc-8.3.0-p3poxnd

# get absolute dir in which is this script stored
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p mpich-install
wget https://www.mpich.org/static/downloads/3.4.2/mpich-3.4.2.tar.gz
tar xzf mpich-3.4.2.tar.gz
cd mpich-3.4.2
./configure --prefix=$CWD/mpich-install --with-device=ch4:ofi
make -j4
make install

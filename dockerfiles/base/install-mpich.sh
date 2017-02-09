#!/bin/bash
# script will install mpich library
# to do that we need to install g++ and gfortran
set -x

# config
MPICH_TMP=/tmp/mpich
MPICH_URL=http://flow.nti.tul.cz/libraries/mpich-3.2.0.tar.gz


sudo apt-get -y install g++ gfortran

# download and untar lib
mkdir -p $MPICH_TMP
cd $MPICH_TMP
wget $MPICH_URL
tar -xf mpich-3.2.0.tar.gz
cd mpich-3.2

# install
./configure --enable-fast=O3,ndebug --disable-error-checking --without-timing --without-mpit-pvars
make
make install


# clean up
cd /
rm -rf $MPICH_TMP
sudo apt-get -y --purge autoremove g++ gfortran
#!/bin/bash
# install OSU Micro-Benchmarks

mkdir -p ~/git/github.com/ULHPC
cd ~/git/github.com/ULHPC
git clone https://github.com/ULHPC/tutorials.git
cd tutorials
make setup
cd ~/git/github.com/ULHPC
git clone https://github.com/ULHPC/launcher-scripts.git

mkdir -p ~/tutorials/OSU-MicroBenchmarks
cd ~/tutorials/OSU-MicroBenchmarks
ln -s ~/git/github.com/ULHPC/tutorials/parallel/mpi/OSU_MicroBenchmarks/ ref.ulhpc.d
ln -s ref.ulhpc.d/Makefile .
ln -s ref.ulhpc.d/scripts .

cd ~/tutorials/OSU-MicroBenchmarks
mkdir src
cd src
export OSU_VERSION=5.5
wget --no-check-certificate http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-${OSU_VERSION}.tar.gz
tar xvzf osu-micro-benchmarks-${OSU_VERSION}.tar.gz
cd osu-micro-benchmarks-${OSU_VERSION}

cd ~/tutorials/OSU-MicroBenchmarks/
mkdir build.mpich
cd  build.mpich
../src/osu-micro-benchmarks-${OSU_VERSION}/configure CC=mpicc CFLAGS=-I$(pwd)/../src/osu-micro-benchmarks-${OSU_VERSION}/util --prefix=$(pwd)
make && make install

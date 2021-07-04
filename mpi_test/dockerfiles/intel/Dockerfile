FROM ubuntu:20.04

RUN apt update && apt install -y \
  wget \
  make \
  git \
  gnupg2

# install intel mpi
RUN wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
  apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
  rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
  echo "deb https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list && \
  apt update && DEBIAN_FRONTEND="noninteractive" apt install -y \
  intel-basekit \
  intel-hpckit

# install OSU Micro-Benchmarks
RUN mkdir -p /git/github.com/ULHPC && \
  cd /git/github.com/ULHPC && \
  git clone https://github.com/ULHPC/tutorials.git && \
  cd tutorials && \
  make setup && \
  cd /git/github.com/ULHPC && \
  git clone https://github.com/ULHPC/launcher-scripts.git

RUN mkdir -p /tutorials/OSU-MicroBenchmarks && \
  cd /tutorials/OSU-MicroBenchmarks && \
  ln -s /git/github.com/ULHPC/tutorials/parallel/mpi/OSU_MicroBenchmarks/ ref.ulhpc.d && \
  ln -s ref.ulhpc.d/Makefile . && \
  ln -s ref.ulhpc.d/scripts .

ENV OSU_VERSION 5.5

RUN cd /tutorials/OSU-MicroBenchmarks && \
  mkdir src && \
  cd src && \
  wget -nv --no-check-certificate http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-${OSU_VERSION}.tar.gz && \
  tar xvzf osu-micro-benchmarks-${OSU_VERSION}.tar.gz

RUN . /opt/intel/oneapi/setvars.sh && \
  cd /tutorials/OSU-MicroBenchmarks/ && \
  mkdir build.intel && \
  cd build.intel && \
  ../src/osu-micro-benchmarks-${OSU_VERSION}/configure CC=mpiicc CXX=mpiicpc CFLAGS=-I$(pwd)/../src/osu-micro-benchmarks-${OSU_VERSION}/util --prefix=$(pwd) && \
  make -j4 && make install

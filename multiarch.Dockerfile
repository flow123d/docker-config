
ARG DEFAULT_UBUNTU=20.04
FROM ubuntu:${DEFAULT_UBUNTU}

# [gcc]
#  0  /usr/bin/gcc-9     9   auto mode
#  1  /usr/bin/gcc-6     6   manual mode
#  2  /usr/bin/gcc-7     7   manual mode
#  3  /usr/bin/gcc-8     8   manual mode
#  4  /usr/bin/gcc-9     9   manual mode
ARG DEFAULT_GCC=/usr/bin/gcc-6

# [g++]
# 0   /usr/bin/g++-9     9  auto mode
# 1   /usr/bin/g++-6     6  manual mode
# 2   /usr/bin/g++-7     7  manual mode
# 3   /usr/bin/g++-8     8  manual mode
# 4   /usr/bin/g++-9     9  manual mode
ARG DEFAULT_GXX=/usr/bin/g++-6

# [c++]
# 0   /usr/bin/g++      20  auto mode
# 1   /usr/bin/clang++  10  manual mode
# 2   /usr/bin/g++      20  manual mode
ARG DEFAULT_CXX=/usr/bin/clang++

# [mpicc] OMPI_CC
# gcc
# clang
ARG DEFAULT_MPICC=gcc

# [mpicc] OMPI_CXX
# g++
# clang++
ARG DEFAULT_MPICXX=g++


# Debug or Release
ARG BUILD_TYPE=Debug

# [versions for petsc and other custom packages]
ARG VERSION_MPICH=3.2.0
ARG VERSION_YAMLCPP=0.5.2
ARG VERSION_PETSC=3.8.3
ARG VERSION_ARMADILLO=8.3.4
ARG VERSION_BDDCML=2.5.0
ARG VERSION_YAMLCPP=0.6.3

# --------------------------------------------------- configuration end


# disable interactive tzdata config
ENV DEBIAN_FRONTEND="noninteractive" TZ="Europe/Prague" OMPI_CC=${DEFAULT_MPICC} OMPI_CXX=${DEFAULT_MPICXX}

# install default packages
RUN apt-get update && apt-get -y install \
    build-essential \
    libboost1.67-all-dev \
    bash-completion \
    sudo \
    cmake \
    git \
    valgrind \
    perl \
    gfortran \
    pandoc \
    ccache \
    vim \
    make \
    wget  \
    python3 \
    python2 \
    apt-utils \
    nano \
    less \
    man \
    nano \
    tree \
    python3-dev \
    python3-pip \
    gcc-7 g++-7 \
    gcc-8 g++-8 \
    gcc-9 g++-9 \
    libblas* \
    liblapack* \
    lib32z1* \
    libpugixml* \
 && cp /etc/apt/sources.list /etc/apt/sources.list.backup \
 && echo "\ndeb http://archive.ubuntu.com/ubuntu/ bionic main universe\n" >> /etc/apt/sources.list \
 && apt update && apt -y install \
    gcc-6 g++-6 \
 && mv /etc/apt/sources.list.backup /etc/apt/sources.list \
 && apt update && apt -y install \
    clang \
 && echo "packages installed"

# /usr/bin/c++ |-> /etc/alternatives/c++ -> /usr/bin/g++ -> /etc/alternatives/g++ |-> /usr/bin/g++-9
#              |                                                                  |-> /usr/bin/g++-8
#              |                                                                  |-> /usr/bin/g++-7
#              |                                                                  |-> /usr/bin/g++-6
#              |-> /etc/alternatives/c++ -> /usr/bin/clang++
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
 && update-alternatives --install /usr/bin/python python /usr/bin/python2 20 \
 && update-alternatives --display python \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 6 \
 && update-alternatives --display g++ \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 6 \
 && update-alternatives --display gcc \
 && echo "update-alternatives default value set"


# set desired compilers
RUN update-alternatives --install /usr/bin/gcc gcc ${DEFAULT_GCC} 100 \
 && update-alternatives --install /usr/bin/g++ g++ ${DEFAULT_GXX} 100 \
 && update-alternatives --install /usr/bin/c++ c++ ${DEFAULT_CXX} 100 \
 && update-alternatives --auto gcc \
 && update-alternatives --auto g++ \
 && update-alternatives --auto c++ \
 && echo "gcc   " && gcc --version \
 && echo "g++   " && g++ --version \
 && echo "c++   " && c++ --version \
 && echo "mpicc " && mpicc --version \
 && echo "mpic++" && mpic++ --version \
 && echo "update-alternatives requested version set"


# some pip packages
RUN pip3 install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo \
    pandoc-fignos \
    pandoc-tablenos


# add auto bash-completion load
COPY autoload.sh /etc/profile.d/autoload.sh


# copy cmakefiles to build custom packages
COPY cmakefiles /tmp/cmakefiles

# install custom packages
RUN cd /tmp/cmakefiles && make -C mpich build_type=${BUILD_TYPE} install_prefix=/usr/local        version=${VERSION_MPICH} install
RUN cd /tmp/cmakefiles && make -C petsc build_type=${BUILD_TYPE} install_prefix=/usr/local        version=${VERSION_PETSC} install
RUN cd /tmp/cmakefiles && make -C armadillo build_type=${BUILD_TYPE} install_prefix=/usr/local    version=${VERSION_ARMADILLO} install
RUN cd /tmp/cmakefiles && make -C yamlcpp build_type=${BUILD_TYPE} install_prefix=/usr/local      version=${VERSION_YAMLCPP} install
RUN cd /tmp/cmakefiles && make -C bddcml build_type=${BUILD_TYPE} install_prefix=/usr/local       version=${VERSION_BDDCML} install
RUN echo "custom packages installed"


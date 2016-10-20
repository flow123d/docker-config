# BASE-BUILD Dockerfile for running flow123d
FROM flow123d/base
MAINTAINER Jan Hybs

# install basic set of tools
RUN sudo apt-get update && sudo apt-get install -y  \
    cmake \
    git \
    python \
    python-dev \
    python-pip \
    valgrind \
    perl \
    gfortran \
    gcc \
    g++ \
    pandoc \
    clang \
    vim \
    ccache
    
# install additional tools and libs
RUN sudo apt-get update && sudo apt-get install -y \
    libblas* \
    liblapack* \
    libmpich*

# install boost
RUN sudo apt-get update && sudo apt-get install -y  \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-regex-dev \
    libboost-filesystem-dev 

# install python basic tools
RUN sudo pip install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo


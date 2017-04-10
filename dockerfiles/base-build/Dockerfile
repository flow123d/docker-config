# BASE-BUILD Dockerfile for running flow123d
FROM flow123d/base
MAINTAINER Jan Hybs

# install basic set of tools and pandoc tools
RUN sudo apt-get update && sudo apt-get install -y  \
    cmake \
    git \
    python3-dev \
    python3-pip \
    valgrind \
    perl \
    gfortran \
    gcc \
    g++ \
    pandoc \
    clang \
    vim \
    ccache \
    lib32z1 \
    lib32z1-dev \
    libpugixml-dev \
    libpugixml1v5 \
    libpython3.4

# install boost
RUN sudo apt-get update && sudo apt-get install -y  \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-regex-dev \
    libboost-filesystem-dev 

# install additional tools and libs
RUN sudo apt-get update && sudo apt-get install -y \
    libblas* \
    liblapack* 

# install python basic libs and install pandoc tools
RUN sudo pip3 install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo \
    pandoc-fignos \
    pandoc-tablenos

# install doxygen and graphviz, latex
RUN sudo apt-get update && sudo apt-get install -y  \
    doxygen \
    graphviz \
    texlive-full \
    imagemagick

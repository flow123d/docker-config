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
    ccache 

# install boost
RUN sudo apt-get update && sudo apt-get install -y  \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-regex-dev \
    libboost-filesystem-dev 

# install additional tools and libs
RUN sudo apt-get update && sudo apt-get install -y \
    libblas* \
    liblapack* \
    lib32z1 \
    lib32z1-dev \
    libpugixml1v5 \    
    libpugixml-dev \
    libpython3.4   

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
    texlive \
    texlive-base \
    texlive-binaries \
    texlive-extra-utils \
    texlive-font-utils \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-pictures \
    texlive-pstricks \
    texlive-science \        
    imagemagick



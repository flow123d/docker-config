# BASE-BUILD Dockerfile for running flow123d
FROM flow123d/base
MAINTAINER Jan Hybs


# install only tools needed to production
RUN sudo apt-get update && sudo apt-get install -y  \
    perl \
    python \
    python-pip \
    python-dev \
    libgfortran3 \
    libblas3 \
    liblapack3 \
    libopenmpi1.10 \
    libhwloc5 \
    openmpi*

# install python basic tools
RUN sudo pip install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo

# install pandoc tools
RUN sudo apt-get update && sudo apt-get install -y  \
    lib32z1

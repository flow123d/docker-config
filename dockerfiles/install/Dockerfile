# BASE-BUILD Dockerfile for running flow123d
FROM flow123d/base
MAINTAINER Jan Hybs


# install only tools needed to production
RUN sudo apt-get update && sudo apt-get install -y  \
    perl \
    python3-pip \
    python3-dev \
    libgfortran3 \
    libblas3 \
    liblapack3 \
    libopenmpi1.10 \
    libhwloc5 \
    openmpi*

    
# create shortcut for python and pip
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip

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

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
    libmpich12 \
    libhwloc5 \
    mpich

# install python basic tools
RUN sudo pip install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic
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
    libhwloc5 \
    libpugixml1v5 \
    lib32z1

# install python basic tools
RUN sudo pip3 install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo

# clear apt cache
RUN rm -rf /var/lib/apt

# BASE Dockerfile for running flow123d
FROM ubuntu:16.04
MAINTAINER Jan Hybs

# fix bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install basic set of tools
RUN apt-get update && apt-get install -y  \
    sudo \
    nsis \
    wget  \
    nano \
    less \
    cmake \
    man


# default working directory
RUN mkdir -p /pack/libs
WORKDIR /pack

# copy cmake file and makefile
COPY CMakeLists.txt /pack/CMakeLists.txt
COPY makefile       /pack/makefile
COPY src            /pack/src


# download docker toolbox for windows (version 1.12.2)
# RUN wget -q https://github.com/docker/toolbox/releases/download/v1.12.2/DockerToolbox-1.12.2.exe -O libs/DockerToolbox.exe

# download flow123d install image
# RUN wget -q http://flow.nti.tul.cz/docker-images/2.0.0_debug/flow123d-image.tar.gz -O libs/flow123d-install.tar.gz
# RUN wget -q http://flow.nti.tul.cz/docker-images/2.0.0_debug/foobar.tar.gz -O libs/flow123d-install.tar.gz

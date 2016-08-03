# BASE Dockerfile for running flow123d
FROM ubuntu:16.04
MAINTAINER Jan Hybs

# fix bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install basic set of tools
RUN apt-get update && apt-get install -y  \
    sudo \
    make \
    wget  \
    python 

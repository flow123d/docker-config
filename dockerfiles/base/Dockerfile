# BASE Dockerfile for running flow123d
FROM ubuntu:20.04
ARG images_version

MAINTAINER Jan Březina, Jan Hybš

ENV LANG C.UTF-8

# disable interactive tzdata config during apt install
ENV DEBIAN_FRONTEND="noninteractive" TZ="Europe" 

#(??)
# OMPI_CC=${DEFAULT_MPICC} OMPI_CXX=${DEFAULT_MPICXX}

# fix bash (??)
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install basic set of tools
RUN apt-get update && apt-get install -y  \
    sudo \    
    gosu \
    make \
    wget  \    
    bash-completion \
    apt-utils \         
    nano \
    less \
    tzdata

# basic libraries
RUN apt-get update && apt-get install -y  \
    libblas3 \
    liblapack3
    
# Script used later in interactive images as the entry point.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
RUN ls -l /usr/local/bin/entrypoint.sh


# set entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# and default argument
CMD ["/bin/bash"]

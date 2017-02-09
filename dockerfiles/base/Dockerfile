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
    python \
    bash-completion \
    apt-utils \
    nano \
    less \
    man

# add auto bash-completion load
COPY autoload.sh /etc/profile.d/autoload.sh

# add auto bash-completion load
COPY install-mpich.sh /tmp/install-mpich.sh
RUN /tmp/install-mpich.sh
RUN rm -f /tmp/install-mpich.sh

# default entrypoint will be login bash
CMD ["/bin/bash", "-l"]

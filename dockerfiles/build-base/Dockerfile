# Common building tools.
ARG images_version
FROM flow123d/base:${images_version}
MAINTAINER Jan Hybs
ARG images_version´

# Environment variables are part of the images.
# We will use the same base boost package when selectiong specific parts of the BOOST for the install image.
ENV BOOST_VERSION=1.71

ARG BV=${BOOST_VERSION}
ARG boost-libs= \
    libboost-program-options${BV}-dev \
    libboost-serialization${BV}-dev \
    libboost-regex${BV}-dev \
    libboost-filesystem${BV}-dev 

# [gcc]
#  0  /usr/bin/gcc-9     9   auto mode
#  1  /usr/bin/gcc-6     6   manual mode
#  2  /usr/bin/gcc-7     7   manual mode
#  3  /usr/bin/gcc-8     8   manual mode
#  4  /usr/bin/gcc-9     9   manual mode
ARG DEFAULT_GCC=/usr/bin/gcc-9

# [g++]
# 0   /usr/bin/g++-9     9  auto mode
# 1   /usr/bin/g++-6     6  manual mode
# 2   /usr/bin/g++-7     7  manual mode
# 3   /usr/bin/g++-8     8  manual mode
# 4   /usr/bin/g++-9     9  manual mode
ARG DEFAULT_GXX=/usr/bin/g++-9

# [c++]
# 0   /usr/bin/g++      20  auto mode
# 1   /usr/bin/clang++  10  manual mode
# 2   /usr/bin/g++      20  manual mode
ARG DEFAULT_CXX=/usr/bin/g++-9


# install basic set of tools and pandoc tools
RUN sudo apt-get update && sudo apt-get install -y  \
    cmake \
    git \
    python3-dev \
    python3-pip \
    build-essential \    
    ${boost_libs} \    
    python3 \
    python2 \
    apt-utils \
    man \
    tree \
    gfortran \
    gcc-7 g++-7 \
    gcc-8 g++-8 \
    gcc-9 g++-9 \
    clang \
    valgrind \
    libblas-dev \
    liblapack-dev 

    

# /usr/bin/c++ |-> /etc/alternatives/c++ -> /usr/bin/g++ -> /etc/alternatives/g++ |-> /usr/bin/g++-9
#              |                                                                  |-> /usr/bin/g++-8
#              |                                                                  |-> /usr/bin/g++-7
#              |                                                                  |-> /usr/bin/g++-6
#              |-> /etc/alternatives/c++ -> /usr/bin/clang++


RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
 && update-alternatives --install /usr/bin/python python /usr/bin/python2 20 \
 && update-alternatives --display python \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7 \
 && update-alternatives --display g++ \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7 \
 && update-alternatives --display gcc \
 && echo "update-alternatives default value set"

#  && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 6 \
#  && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 6 \


# set desired compilers
RUN update-alternatives --install /usr/bin/gcc gcc ${DEFAULT_GCC} 100 \
 && update-alternatives --install /usr/bin/g++ g++ ${DEFAULT_GXX} 100 \
 && update-alternatives --install /usr/bin/c++ c++ ${DEFAULT_CXX} 100 \
 && update-alternatives --auto gcc \
 && update-alternatives --auto g++ \
 && update-alternatives --auto c++ \
 && echo "gcc   " && gcc --version \
 && echo "g++   " && g++ --version \
 && echo "c++   " && c++ --version \
 && echo "update-alternatives requested version set"


# some pip packages
RUN pip3 install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo \
    pandoc-fignos \
    pandoc-tablenos

    



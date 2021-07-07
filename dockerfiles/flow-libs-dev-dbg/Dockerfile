# FLOW-LIBS-DEV-DBG Dockerfile for running flow123d
ARG images_version
FROM flow123d/build-base:${images_version}
MAINTAINER Jan Hybs
ARG images_version

ENV BUILD_TYPE=Debug

# adding packages used specifically in Flow123d builds
RUN sudo apt-get update && sudo apt-get install -y  \
    pandoc \
    ccache \
    perl 


# install boost - part of build-base
# RUN sudo apt-get update && sudo apt-get install -y  \
#     libboost-program-options-dev \
#     libboost-serialization-dev \
#     libboost-regex-dev \
#     libboost-filesystem-dev 

# install additional tools and libs
RUN sudo apt-get update && sudo apt-get install -y \
    libblas-dev \
    liblapack-dev\
    lib32z1 \
    lib32z1-dev \
    libpugixml1v5 \    
    libpugixml-dev \
    libpython3.4   

# part of build-base
# install python basic libs and install pandoc tools
# RUN sudo /usr/bin/python3 -m pip install \
#     pyyaml \
#     markdown \
#     psutil \
#     simplejson \
#     formic \
#     pymongo \
#     pandoc-fignos \
#     pandoc-tablenos
    
    

# install doxygen and graphviz, latex
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends  \
    doxygen \
    graphviz \
    texlive \
    texlive-base \
    texlive-binaries \
    texlive-extra-utils \
    texlive-font-utils \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-pictures \
    texlive-pstricks \
    texlive-science \        
    imagemagick






# install libraries
RUN ls .
RUN cd /usr/local && tar xzf packages/yamlcpp_${BUILD_TYPE}.tar.gz
RUN cd /usr/local && tar xzf packages/armadillo_${BUILD_TYPE}.tar.gz
RUN cd /usr/local && tar xzf packages/mpich_${BUILD_TYPE}.tar.gz
RUN cd /usr/local && tar xzf packages/petsc_${BUILD_TYPE}.tar.gz
RUN cd /usr/local && tar xzf packages/bddcml_${BUILD_TYPE}.tar.gz



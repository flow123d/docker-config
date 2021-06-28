# FLOW-LIBS-DEV-DBG Dockerfile for running flow123d
FROM flow123d/base-build
MAINTAINER Jan Hybs

# defalt BUILD_TYPE is debug
ARG BUILD_TYPE=debug

    gfortran \
    gcc \
    g++ \
    pandoc \
    clang \
    vim \
    ccache 
    valgrind \
    perl \

    lib32z1* \
    libpugixml*


# install boost
RUN sudo apt-get update && sudo apt-get install -y  \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-regex-dev \
    libboost-filesystem-dev 

# install additional tools and libs
RUN sudo apt-get update && sudo apt-get install -y \
    libblas* \
    liblapack* \
    lib32z1 \
    lib32z1-dev \
    libpugixml1v5 \    
    libpugixml-dev \
    libpython3.4   

# install python basic libs and install pandoc tools
RUN sudo pip3 install \
    pyyaml \
    markdown \
    psutil \
    simplejson \
    formic \
    pymongo \
    pandoc-fignos \
    pandoc-tablenos

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
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-pictures \
    texlive-pstricks \
    texlive-science \        
    imagemagick


# install latex
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends  \
    texlive-base 

#    texlive-binaries \
#    texlive-lang-czechslovak \
#    texlive-latex-base \
#    texlive-latex-recommended 



# copy install script
COPY install_lib.sh /usr/bin/install_lib.sh

# install libraries
RUN /usr/bin/install_lib.sh petsc       3.8.3 ${BUILD_TYPE}
RUN /usr/bin/install_lib.sh yamlcpp     0.5.2 ${BUILD_TYPE}
RUN /usr/bin/install_lib.sh armadillo   8.4.3 ${BUILD_TYPE}
RUN /usr/bin/install_lib.sh bddcml      2.4.0 ${BUILD_TYPE}




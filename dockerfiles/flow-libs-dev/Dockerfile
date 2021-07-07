# FLOW-LIBS-DEV-DBG Dockerfile for running flow123d
ARG images_version
ARG BUILD_TYPE

ARG sourceimg="flow123d/libs-build-debug:latest"
FROM $sourceimg as builder


ARG images_version
FROM flow123d/build-base:${images_version}
MAINTAINER Jan Hybs

ARG images_version
ARG BUILD_TYPE


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
# RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends  \
#     doxygen \
#     graphviz \
#     texlive \
#     texlive-base \
#     texlive-binaries \
#     texlive-extra-utils \
#     texlive-font-utils \
#     texlive-fonts-extra \
#     texlive-fonts-recommended \
#     texlive-plain-generic \
#     texlive-latex-base \
#     texlive-latex-extra \
#     texlive-latex-recommended \
#     texlive-pictures \
#     texlive-pstricks \
#     texlive-science \        
#     imagemagick


ARG ver_yamlcpp=0.6.3
ARG ver_armadillo=10.5.2
ARG ver_mpich=3.4.2
ARG ver_petsc=3.15.1
ARG ver_bddcml=2.6

# install libraries
COPY --from=builder /usr/local/yamlcpp_$ver_yamlcpp /usr/local/yamlcpp_$ver_yamlcpp
COPY --from=builder /usr/local/armadillo_${ver_armadillo} /usr/local/armadillo_${ver_armadillo}
COPY --from=builder /usr/local/mpich_${ver_mpich} /usr/local/mpich_${ver_mpich}
COPY --from=builder /usr/local/petsc_${ver_petsc} /usr/local/petsc_${ver_petsc}
COPY --from=builder /usr/local/bddcml_${ver_bddcml} /usr/local/bddcml_${ver_bddcml}
RUN echo ${BUILD_TYPE} ${images_version} >/.dockerversion
RUN cat /.dockerversion

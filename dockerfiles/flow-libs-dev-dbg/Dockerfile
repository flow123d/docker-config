# FLOW-LIBS-DEV-DBG Dockerfile for running flow123d
FROM flow123d/base-build
MAINTAINER Jan Hybs

# defalt BUILD_TYPE is debug
ARG BUILD_TYPE=debug

# copy install script
COPY install_lib.sh /usr/bin/install_lib.sh

# install libraries
RUN /usr/bin/install_lib.sh petsc       3.8.3 ${BUILD_TYPE}
RUN /usr/bin/install_lib.sh yamlcpp     0.5.2 ${BUILD_TYPE}
RUN /usr/bin/install_lib.sh armadillo   8.4.3 ${BUILD_TYPE}
RUN /usr/bin/install_lib.sh bddcml      2.4.0 ${BUILD_TYPE}

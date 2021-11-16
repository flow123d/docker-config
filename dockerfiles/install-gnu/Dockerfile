# FLOW-LIBS-DEV-DBG Dockerfile for running flow123d
ARG images_version
ARG source_image
FROM ${source_image} as builder


ARG images_version
FROM flow123d/base-gnu:${images_version}
MAINTAINER Jan Brezina

ARG images_version
ARG BUILD_TYPE=Release


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

RUN echo /usr/local/mpich_${ver_mpich}/bin/mpicc > /.mpiccpath
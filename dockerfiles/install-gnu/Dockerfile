# FLOW-LIBS-DEV-DBG Dockerfile for running flow123d
ARG images_version
ARG source_image
FROM ${source_image} as builder


ARG images_version
FROM flow123d/base-gnu:${images_version}
MAINTAINER Jan Brezina

ARG images_version
ARG BUILD_TYPE=Release


ARG ver_yamlcpp
ARG ver_armadillo
ARG ver_mpich
ARG ver_petsc
ARG ver_bddcml
ARG ver_permon

# install libraries
COPY --from=builder /usr/local/yamlcpp_$ver_yamlcpp /usr/local/yamlcpp_$ver_yamlcpp
COPY --from=builder /usr/local/armadillo_${ver_armadillo} /usr/local/armadillo_${ver_armadillo}
COPY --from=builder /usr/local/mpich_${ver_mpich} /usr/local/mpich_${ver_mpich}
COPY --from=builder /usr/local/petsc_${ver_petsc} /usr/local/petsc_${ver_petsc}
COPY --from=builder /usr/local/bddcml_${ver_bddcml} /usr/local/bddcml_${ver_bddcml}
COPY --from=builder /usr/local/permon_${ver_permon} /usr/local/permon_${ver_permon}

RUN echo ${BUILD_TYPE} ${images_version} >/.dockerversion; \
    echo /usr/local/mpich_${ver_mpich}/bin/mpicc >/.mpiccpath; \
    ln -s /usr/local/${ver_mpich}/bin/mpirun /usr/bin/mpirun; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpicc; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpicxx; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpif90; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpifort

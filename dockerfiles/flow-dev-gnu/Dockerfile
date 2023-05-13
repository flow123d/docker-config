# BASE-BUILD Dockerfile for running flow123d
ARG images_version
FROM flow123d/base-build-gnu:${images_version} as libs-build
ARG BUILD_TYPE

# TODO:
# COPY invalidates all layers even if the chance takes place only in configuration of a single library
# Resolution:
# - break into multiple stages one for each library, copy only relevant directory
# - merge with flow-dev-gnu
# auxiliary build image 
# just build libraries Dbug or Release using ${BUILD_TYPE} variable

RUN mkdir /build
COPY libs-build-gnu/common_cmake.mk /build/common_cmake.mk
COPY libs-build-gnu/common_configure.mk /build/common_configure.mk


### YAMLCPP
COPY libs-build-gnu/yamlcpp /build/yamlcpp
ARG ver_yamlcpp
# Need to copy these into ../libs-dbg/Docrefile
RUN 	echo "*** building YAMLCPP ***"; \
	make -C /build/yamlcpp build_type=${BUILD_TYPE} version=$ver_yamlcpp install
	
### ARMADILO
COPY libs-build-gnu/armadillo /build/armadillo
ARG ver_armadillo
RUN     echo "*** building Armadillo ***"; \
	make -C /build/armadillo build_type=${BUILD_TYPE} version=$ver_armadillo install

### MPICH
COPY libs-build-gnu/mpich /build/mpich
ARG ver_mpich
RUN     echo "*** building MPICH ***"; \
	make -C /build/mpich build_type=${BUILD_TYPE} version=$ver_mpich install

### PETSC
COPY libs-build-gnu/petsc /build/petsc
ARG ver_petsc
ARG ver_hypre
RUN     echo "*** building PETSC ***"; \
	make -C /build/petsc build_type=${BUILD_TYPE}  mpich_lib=mpich_${ver_mpich} version=${ver_petsc} hypre_version=${ver_hypre} install

### BDDCML
COPY libs-build-gnu/bddcml /build/bddcml
ARG ver_bddcml
RUN     echo "*** building BDDCML ***"; \
	make -C /build/bddcml build_type=${BUILD_TYPE} version=${ver_bddcml} mpich_lib=mpich_${ver_mpich} petsc_lib=petsc_${ver_petsc} install

### PERMON
COPY libs-build-gnu/permon /build/permon
ARG ver_permon
RUN     echo "*** building PERMON ***"; \
	make -C /build/permon build_type=${BUILD_TYPE} version=${ver_permon} petsc_lib=petsc_${ver_petsc} install



##################################
# Target flow-dev-gnu image

ARG images_version
FROM flow123d/base-build-gnu:${images_version} as flow-dev-gnu
MAINTAINER Jan Brezina

ARG images_version
ARG BUILD_TYPE

ARG ver_yamlcpp
ARG ver_armadillo
ARG ver_mpich
ARG ver_petsc
ARG ver_bddcml
ARG ver_permon

# install libraries
COPY --from=libs-build /usr/local/yamlcpp_$ver_yamlcpp /usr/local/yamlcpp_$ver_yamlcpp
COPY --from=libs-build /usr/local/armadillo_${ver_armadillo} /usr/local/armadillo_${ver_armadillo}
COPY --from=libs-build /usr/local/mpich_${ver_mpich} /usr/local/mpich_${ver_mpich}
COPY --from=libs-build /usr/local/petsc_${ver_petsc} /usr/local/petsc_${ver_petsc}
COPY --from=libs-build /usr/local/bddcml_${ver_bddcml} /usr/local/bddcml_${ver_bddcml}
COPY --from=libs-build /usr/local/permon_${ver_permon} /usr/local/permon_${ver_permon}

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends  \  
    python3-vtk7

RUN echo ${BUILD_TYPE} ${images_version} >/.dockerversion


###################################
# Target install-gnu image


ARG images_version
FROM flow123d/base-gnu:${images_version} as install-gnu
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
COPY --from=libs-build /usr/local/yamlcpp_$ver_yamlcpp /usr/local/yamlcpp_$ver_yamlcpp
COPY --from=libs-build /usr/local/armadillo_${ver_armadillo} /usr/local/armadillo_${ver_armadillo}
COPY --from=libs-build /usr/local/mpich_${ver_mpich} /usr/local/mpich_${ver_mpich}
COPY --from=libs-build /usr/local/petsc_${ver_petsc} /usr/local/petsc_${ver_petsc}
COPY --from=libs-build /usr/local/bddcml_${ver_bddcml} /usr/local/bddcml_${ver_bddcml}
COPY --from=libs-build /usr/local/permon_${ver_permon} /usr/local/permon_${ver_permon}

RUN echo ${BUILD_TYPE} ${images_version} >/.dockerversion; \
    echo /usr/local/mpich_${ver_mpich}/bin/mpicc >/.mpiccpath; \
    ln -s /usr/local/${ver_mpich}/bin/mpirun /usr/bin/mpirun; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpicc; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpicxx; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpif90; \
    ln -s /usr/local/${ver_mpich}/bin/mpicc /usr/bin/mpifort

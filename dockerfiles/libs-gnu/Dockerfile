# BASE-BUILD Dockerfile for running flow123d
ARG images_version
FROM flow123d/base-build-gnu:${images_version}
MAINTAINER Jan Hybs
ARG BUILD_TYPE

# auxiliary build image 
# just build libraries Dbug or Release using ${BUILD_TYPE} variable
COPY libs-build-gnu /libs-build-gnu

# Need to copy these into ../libs-dbg/Docrefile
ARG ver_yamlcpp
ARG ver_armadillo
ARG ver_mpich
ARG ver_petsc
ARG ver_hypre
ARG ver_bddcml
ARG ver_permon

RUN 	echo "*** building YAMLCPP ***"; \
	make -C libs-build-gnu/yamlcpp build_type=${BUILD_TYPE} version=$ver_yamlcpp install

RUN     echo "*** building Armadillo ***"; \
	make -C libs-build-gnu/armadillo build_type=${BUILD_TYPE} version=$ver_armadillo install


RUN     echo "*** building MPICH ***"; \
	make -C libs-build-gnu/mpich build_type=${BUILD_TYPE} version=$ver_mpich install


RUN     echo "*** building PETSC ***"; \
	make -C libs-build-gnu/petsc build_type=${BUILD_TYPE} mpich_lib=mpich_${ver_mpich} version=${ver_petsc} hypre_version=${ver_hypre} install


RUN     echo "*** building BDDCML ***"; \
	make -C libs-build-gnu/bddcml build_type=${BUILD_TYPE} version=${ver_bddcml} mpich_lib=mpich_${ver_mpich} petsc_lib=petsc_${ver_petsc} install


RUN     echo "*** building Permon ***"; \
	make -C libs-build-gnu/permon build_type=${BUILD_TYPE} version=${ver_permon} petsc_lib=petsc_${ver_petsc} install
#make build_type=Debug version=3.15.0 petsc_lib=petsc_3.15.1 install

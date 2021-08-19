# BASE-BUILD Dockerfile for running flow123d
ARG images_version
FROM flow123d/base-build-gnu:${images_version}
MAINTAINER Jan Hybs
ARG BUILD_TYPE

# auxiliary build image 
# just build libraries Dbug or Release using ${BUILD_TYPE} variable
COPY libs-build /libs-build 

# Need to copy these into ../flow-libs-dbg/Docrefile
ARG ver_yamlcpp=0.6.3
ARG ver_armadillo=10.5.2
ARG ver_mpich=3.4.2
ARG ver_petsc=3.15.1
ARG ver_bddcml=2.6

RUN 	echo "*** building YAMLCPP ***"; \
	make -C libs-build/yamlcpp build_type=${BUILD_TYPE} version=$ver_yamlcpp install

RUN     echo "*** building Armadillo ***"; \
	make -C libs-build/armadillo build_type=${BUILD_TYPE} version=$ver_armadillo install


RUN     echo "*** building MPICH ***"; \
	make -C libs-build/mpich build_type=${BUILD_TYPE} version=$ver_mpich install


RUN     echo "*** building PETSC ***"; \
	make -C libs-build/petsc build_type=${BUILD_TYPE} mpich_lib=mpich_${ver_mpich} version=${ver_petsc}  install


RUN     echo "*** building BDDCML ***"; \
	make -C libs-build/bddcml build_type=${BUILD_TYPE} version=$ver_bddcml mpich_lib=mpich_${ver_mpich} petsc_lib=petsc_${ver_petsc} install


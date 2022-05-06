# BASE-BUILD Dockerfile for running flow123d
ARG images_version
FROM flow123d/base-build-intel:${images_version}
MAINTAINER Jan Hybs
ARG BUILD_TYPE

# auxiliary build image 
# just build libraries Dbug or Release using ${BUILD_TYPE} variable
COPY libs-build-intel /libs-build-intel

# Need to copy these into ../libs-dbg/Docrefile
ARG ver_yamlcpp
ARG ver_armadillo
ARG ver_mpich
ARG ver_petsc
ARG ver_hypre
ARG ver_bddcml
ARG ver_permon


RUN 	echo "*** building YAMLCPP ***"; \
	. /opt/intel/oneapi/setvars.sh; \
	make -C libs-build-intel/yamlcpp build_type=${BUILD_TYPE} version=$ver_yamlcpp install

RUN     echo "*** building Armadillo ***"; \
	. /opt/intel/oneapi/setvars.sh; \
	make -C libs-build-intel/armadillo build_type=${BUILD_TYPE} version=$ver_armadillo install


#RUN     echo "*** building MPICH ***"; \
#	make -C libs-build-intel-gnu/mpich build_type=${BUILD_TYPE} version=$ver_mpich install


RUN     echo "*** building PETSC ***"; \
	. /opt/intel/oneapi/setvars.sh; \
	make -C libs-build-intel/petsc build_type=${BUILD_TYPE} version=${ver_petsc}  install


RUN     echo "*** building BDDCML ***"; \
	. /opt/intel/oneapi/setvars.sh; \
	make -C libs-build-intel/bddcml build_type=${BUILD_TYPE} version=$ver_bddcml petsc_lib=petsc_${ver_petsc} install

# RUN     echo "*** building Permon ***"; \
# 	. /opt/intel/oneapi/setvars.sh; \
# 	make -C libs-build-intel/permon build_type=${BUILD_TYPE} version=${ver_permon} petsc_lib=petsc_${ver_petsc} install
#make build_type=Debug version=3.15.0 petsc_lib=petsc_3.15.1 install

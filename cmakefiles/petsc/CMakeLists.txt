cmake_minimum_required(VERSION 2.8)

project(PETSC CXX C Fortran)
find_program (MAKE_EXECUTABLE NAMES make gmake)

# used when --with-mpi-dir=<MPI_DIR>
find_package(MPI REQUIRED)
# find_package(MPI REQUIRED)
get_filename_component(MPI_DIR ${MPI_CXX_COMPILER} DIRECTORY)
# set(MPI_DIR "/usr/lib/openmpi")

set(PETSC_VERSION_MAJOR "3")
set(PETSC_VERSION_MINOR "6")
set(PETSC_VERSION_PATCH "1")
set(PETSC_VERSION "${PETSC_VERSION_MAJOR}.${PETSC_VERSION_MINOR}.${PETSC_VERSION_PATCH}")

# default variables
SET(INSTALL_DIR "${CMAKE_BINARY_DIR}")
SET(INSTALL_URL "http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${PETSC_VERSION}.tar.gz")

# set petsc arch based on CMAKE_BUILD_TYPE
#     linux-Debug or linux-Release
SET(PETSC_ARCH      "linux-${CMAKE_BUILD_TYPE}")
SET(PETSC_DIR       "${INSTALL_DIR}/src/")
SET(MAKE_NUMCPUS    2)

# setup external project with target petsc-lib
include(ExternalProject)
ExternalProject_Add(external-lib
    DOWNLOAD_DIR        ${INSTALL_DIR} 
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${INSTALL_DIR}/src
    BINARY_DIR          ${INSTALL_DIR}/src
    
    CONFIGURE_COMMAND   bash ${INSTALL_DIR}/conf.sh
    BUILD_COMMAND       make all
    INSTALL_COMMAND     make test
)

# prepare configure script for petsc and copy if different to isntall dir
configure_file(
    ${CMAKE_SOURCE_DIR}/config/${CMAKE_BUILD_TYPE}.config.sh
    ${INSTALL_DIR}/conf_tmp.sh
    @ONLY)
execute_process(COMMAND
    ${CMAKE_COMMAND} -E copy_if_different "${INSTALL_DIR}/conf_tmp.sh" "${INSTALL_DIR}/conf.sh")

# patch paths to /usr/lib/petsc
install(
    CODE "execute_process(COMMAND make -C ${CMAKE_BINARY_DIR} patch-path)"
)

# add install rule, for now we copy everything in src dir
install(
	DIRECTORY ${INSTALL_DIR}/src/
	DESTINATION lib/petsc
)
    
set(PETSC_OLD_PATH "${INSTALL_DIR}/src")
set(PETSC_NEW_PATH "/usr/lib/petsc")
set(PETSC_REPLACE_FILES 
    "${PETSC_DIR}/linux-${CMAKE_BUILD_TYPE}/include/petscconf.h"
    "${PETSC_DIR}/linux-${CMAKE_BUILD_TYPE}/lib/petsc/conf/petscvariables")

add_custom_target(patch-path
    COMMAND sed -i "s#${PETSC_OLD_PATH}#${PETSC_NEW_PATH}#g" ${PETSC_REPLACE_FILES}
)


# CPack configuration 
# SET(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
SET(CPACK_PACKAGE_FILE_NAME "PETSC_${PETSC_VERSION}")
SET(CPACK_GENERATOR "DEB;TGZ;ZIP")
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)

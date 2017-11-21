cmake_minimum_required(VERSION 2.8)

#
# This file should allow:
# - automatic build of PETSC from official sources or custom URL
# - and its installation to system (e.g. within Docker conteiner)
# 
#   DOWNLOAD_URL - URL of the source tarball. Should be of correct version.
#   PETSC_ARCH - name of particular PETSC build. Default is "linux-${BUILD_TYPE}"
#   NJOBS - number of threas to use in build

project(PETSC CXX C Fortran)
#find_program (MAKE_EXECUTABLE NAMES make gmake)

# used when --with-mpi-dir=<MPI_DIR>
#find_package(MPI REQUIRED)
# find_package(MPI REQUIRED)
#get_filename_component(MPI_DIR ${MPI_CXX_COMPILER} DIRECTORY)
#set(MPI_DIR "/usr/lib/openmpi")


set(PETSC_VERSION "3.6.1")
if(NOT DOWNLOAD_URL)
    SET(DOWNLOAD_URL "http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${PETSC_VERSION}.tar.gz")
    #SET(INSTALL_URL "http://flow.nti.tul.cz/libraries/petsc-lite-${PETSC_VERSION}.tar.gz")
endif()

if(NOT PETSC_ARCH)
    SET(PETSC_ARCH "linux-${CMAKE_BUILD_TYPE}")
endif()    

if(NOT CONFIG_TEMPLATE)
    set(CONFIG_TEMPLATE "${CMAKE_SOURCE_DIR}/config/${CMAKE_BUILD_TYPE}.config.sh")
endif()

SET(PETSC_DIR   "${CMAKE_BINARY_DIR}/src/")


# default variables

# set petsc arch based on CMAKE_BUILD_TYPE
#     linux-Debug or linux-Release

# setup external project with target petsc-lib
include(ExternalProject)
ExternalProject_Add(petsc-lib
    DOWNLOAD_DIR        ${CMAKE_BINARY_DIR}
    URL                 ${DOWNLOAD_URL}
    SOURCE_DIR          ${PETSC_DIR}
    BINARY_DIR          ${PETSC_DIR}

    CONFIGURE_COMMAND   bash ${CMAKE_BINARY_DIR}/conf.sh
    BUILD_COMMAND       make -C ${PETSC_DIR} all
    INSTALL_COMMAND     make -C ${PETSC_DIR} test
)

# prepare configure script for petsc and copy if different to isntall dir
# substitute variables:
#   PETSC_DIR - petsc sources root
#   PETSC_ARCH
#   NJOBS - number of make jobs
configure_file(
    ${CONFIG_TEMPLATE}
    ${CMAKE_BINARY_DIR}/conf_tmp.sh
    @ONLY)
execute_process(COMMAND
    ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_BINARY_DIR}/conf_tmp.sh" "${CMAKE_BINARY_DIR}/conf.sh")

# patch paths to /usr/lib/petsc
#install(
#    CODE "execute_process(COMMAND make -C ${CMAKE_BINARY_DIR} patch-path)"
#)

# add install rule, for now we copy everything in src dir
install(
	DIRECTORY ${PETSC_DIR}
	DESTINATION lib
)

#set(PETSC_OLD_PATH "${INSTALL_DIR}/src")
#set(PETSC_NEW_PATH "/usr/lib/petsc")
#set(PETSC_REPLACE_FILES
#    "${PETSC_DIR}/linux-${CMAKE_BUILD_TYPE}/include/petscconf.h"
#    "${PETSC_DIR}/linux-${CMAKE_BUILD_TYPE}/lib/petsc/conf/petscvariables")

#add_custom_target(patch-path
#    COMMAND sed -i "s#${PETSC_OLD_PATH}#${PETSC_NEW_PATH}#g" ${PETSC_REPLACE_FILES}
#)


# CPack configuration
# SET(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
SET(CPACK_PACKAGE_FILE_NAME "PETSC_${PETSC_VERSION}")
SET(CPACK_GENERATOR "DEB;TGZ;ZIP")
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)


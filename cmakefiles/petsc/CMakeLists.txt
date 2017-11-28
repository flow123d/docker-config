cmake_minimum_required(VERSION 3.2)

project(PETSC CXX C Fortran)
set(EXTRAS ${CMAKE_SOURCE_DIR}/../_CMake)
set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")

# default values
set(LIBRARY_VERSION   "3.6.1" CACHE STRING "Version of the library")
set(LIBRARY_NAME      "petsc" CACHE STRING "Name of the library")
set(LIBRARY_FULL_NAME "${LIBRARY_NAME}-${LIBRARY_VERSION}")
set(INSTALL_PREFIX    "${CMAKE_INSTALL_PREFIX}/${LIBRARY_FULL_NAME}")

# set petsc arch based on CMAKE_BUILD_TYPE
#     linux-Debug or linux-Release
# this is a location where petsc will be installed to
# in will be something like a /usr/local/petsc-3.6.1/
SET(PETSC_DIR     "${CMAKE_INSTALL_PREFIX}" CACHE STRING "Petsc dir value (must end with slash)")
SET(PETSC_ARCH    "linux-${CMAKE_BUILD_TYPE}"   CACHE STRING "Petsc arch value")
SET(MAKE_NUMCPUS   4)


# default variables
set(INSTALL_DIR "${CMAKE_BINARY_DIR}")
set(INSTALL_URL "http://flow.nti.tul.cz/libraries/yaml-cpp-master.zip")


message(STATUS "------------------------------------------------------")
message(STATUS "LIBRARY_NAME          = ${LIBRARY_NAME}")
message(STATUS "LIBRARY_VERSION       = ${LIBRARY_VERSION}")
message(STATUS "CMAKE_INSTALL_PREFIX  = ${CMAKE_INSTALL_PREFIX}")
message(STATUS "PETSC_DIR             = ${PETSC_DIR}")
message(STATUS "PETSC_ARCH            = ${PETSC_ARCH}")
message(STATUS "------------------------------------------------------")

# --------------------------------------------------------------------


# used when --with-mpi-dir=<MPI_DIR>
find_program (MAKE_EXECUTABLE NAMES make gmake)
find_package(MPI REQUIRED)
get_filename_component(MPI_DIR ${MPI_CXX_COMPILER} DIRECTORY)

# default variables
SET(INSTALL_DIR "${CMAKE_BINARY_DIR}")
SET(INSTALL_URL "http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${LIBRARY_VERSION}.tar.gz")
SET(INSTALL_URL "http://flow.nti.tul.cz/libraries/petsc-lite-${LIBRARY_VERSION}.tar.gz")


# setup external project with target petsc-lib
include(ExternalProject)
ExternalProject_Add(external-lib
    DOWNLOAD_DIR        ${INSTALL_DIR}
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${INSTALL_DIR}/src
    BINARY_DIR          ${INSTALL_DIR}/src

    CONFIGURE_COMMAND   bash ${INSTALL_DIR}/conf.sh
    BUILD_COMMAND       make MAKE_NP=${MAKE_NUMCPUS}
    INSTALL_COMMAND     make install
)

# prepare configure script for petsc and copy if different to isntall dir
configure_file(
    ${CMAKE_SOURCE_DIR}/config/${CMAKE_BUILD_TYPE}.config.sh
    ${INSTALL_DIR}/conf_tmp.sh
    @ONLY)
execute_process(COMMAND
    ${CMAKE_COMMAND} -E copy_if_different "${INSTALL_DIR}/conf_tmp.sh" "${INSTALL_DIR}/conf.sh")


# install all which is located in the INSTALL_PREFIX value
install(
    DIRECTORY ${CMAKE_INSTALL_PREFIX}/
    DESTINATION ./
    USE_SOURCE_PERMISSIONS
)

# CPack configuration
set(CPACK_PACKAGE_FILE_NAME "${LIBRARY_FULL_NAME}")
set(CPACK_PACKAGING_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
set(CPACK_GENERATOR "DEB;TGZ;ZIP")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)

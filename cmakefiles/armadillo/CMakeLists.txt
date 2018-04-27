cmake_minimum_required(VERSION 3.2)

project(ARMADILLO CXX C Fortran)
set(EXTRAS ${CMAKE_SOURCE_DIR}/../_CMake)
set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")

# default values
set(LIBRARY_VERSION   "8.3.4"     CACHE STRING "Version of the library")
set(LIBRARY_NAME      "armadillo" CACHE STRING "Name of the library")
set(LIBRARY_FULL_NAME "${LIBRARY_NAME}-${LIBRARY_VERSION}")

# ARMADILLO will not depend on PETSc installation
SET(USE_PETSC   OFF  CACHE STRING "Use petsc installation")


message(STATUS "------------------------------------------------------")
message(STATUS "LIBRARY_NAME          = ${LIBRARY_NAME}")
message(STATUS "LIBRARY_VERSION       = ${LIBRARY_VERSION}")
message(STATUS "CMAKE_INSTALL_PREFIX  = ${CMAKE_INSTALL_PREFIX}")
message(STATUS "USE_PETSC             = ${USE_PETSC}")
message(STATUS "------------------------------------------------------")

# --------------------------------------------------------------------


# if set we use petsc installation
# otherwise we try to look for system libraries of blas and lapack
include(FindBlasLapack)

# print what we found
message(STATUS "BLAS_LIBRARIES = ${BLAS_LIBRARIES}")
message(STATUS "LAPACK_LIBRARIES = ${LAPACK_LIBRARIES}")


# default variables
set(INSTALL_DIR "${CMAKE_BINARY_DIR}")
set(INSTALL_URL "http://flow.nti.tul.cz/libraries/armadillo-${LIBRARY_VERSION}.tar.gz")


# setup external project with target external-lib
include(ExternalProject)
ExternalProject_Add(external-lib
    DOWNLOAD_DIR        ${INSTALL_DIR}
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    BINARY_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    CONFIGURE_COMMAND   cmake -DBLAS_LIBRARY=${BLAS_LIBRARIES}
                              -DLAPACK_LIBRARY=${LAPACK_LIBRARIES}
                              -DBUILD_SHARED_LIBS=Off
                              -DDETECT_HDF5=Off
                              -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                              .
    BUILD_COMMAND       make
    INSTALL_COMMAND     make install
)


# install all which is located in the LIBRARY_FULL_NAME value
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

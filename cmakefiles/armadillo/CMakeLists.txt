cmake_minimum_required(VERSION 2.8)

project(ARMADILLO CXX C Fortran)
set(EXTRAS ${CMAKE_SOURCE_DIR}/../_CMake)
set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")
find_program (MAKE_EXECUTABLE NAMES make gmake)


# This value can se be using makefile
SET(USE_PETSC   Off                         CACHE STRING "Use petsc installation")
SET(PETSC_DIR   "/usr/lib/petsc/"           CACHE STRING "Petsc dir value (must end with slash)")
SET(PETSC_ARCH  "linux-${CMAKE_BUILD_TYPE}" CACHE STRING "Petsc arch value")

# if set we use petsc installation 
# otherwise we try to look for system libraries of blas and lapack
include(FindBlasLapack)

# print what we found
message(STATUS "BLAS_LIBRARIES = ${BLAS_LIBRARIES} ")
message(STATUS "LAPACK_LIBRARIES = ${LAPACK_LIBRARIES}")


# set version
set(ARMADILLO_VERSION_MAJOR "3")
set(ARMADILLO_VERSION_MINOR "4")
set(ARMADILLO_VERSION_PATCH "3")
set(ARMADILLO_VERSION "${ARMADILLO_VERSION_MAJOR}.${ARMADILLO_VERSION_MINOR}.${ARMADILLO_VERSION_PATCH}")

# default variables
set(INSTALL_DIR "${CMAKE_BINARY_DIR}")
set(INSTALL_URL "http://flow.nti.tul.cz/libraries/armadillo-${ARMADILLO_VERSION}.tar.gz")


# setup external project with target external-lib
include(ExternalProject)
ExternalProject_Add(external-lib
    DOWNLOAD_DIR        ${INSTALL_DIR}
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    BINARY_DIR          ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
    # patch to build .a lib instead of .so libs
    PATCH_COMMAND patch ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}/CMakeLists.txt ${EXTRAS}/Patches/armadillo_patch
    CONFIGURE_COMMAND   cmake -DBLAS_LIBRARY=${BLAS_LIBRARIES}
                              -DLAPACK_LIBRARY=${LAPACK_LIBRARIES}
                              -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/${CMAKE_BUILD_TYPE}
                              .
    BUILD_COMMAND       make
    INSTALL_COMMAND     make install
)


install(
    DIRECTORY ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}/lib/
    DESTINATION lib/armadillo/${CMAKE_BUILD_TYPE}/lib
)

install(
    DIRECTORY ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}/include/
    DESTINATION lib/armadillo/${CMAKE_BUILD_TYPE}/include
)

install(
    DIRECTORY ${INSTALL_DIR}/${CMAKE_BUILD_TYPE}/share/
    DESTINATION lib/armadillo/${CMAKE_BUILD_TYPE}/share
)

# CPack configuration
# set(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
set(CPACK_PACKAGE_FILE_NAME "ARMADILLO_${ARMADILLO_VERSION}")
set(CPACK_GENERATOR "DEB;TGZ;ZIP")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)

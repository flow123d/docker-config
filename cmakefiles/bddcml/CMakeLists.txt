
cmake_minimum_required(VERSION 3.2)

project(BDDCML CXX C Fortran)
set(EXTRAS ${CMAKE_SOURCE_DIR}/../_CMake)
set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")

# default values
set(LIBRARY_VERSION   "2.5.0"  CACHE STRING "Version of the library")
set(LIBRARY_NAME      "bddcml" CACHE STRING "Name of the library")
set(LIBRARY_FULL_NAME "${LIBRARY_NAME}-${LIBRARY_VERSION}")

# This value can se be using makefile
SET(USE_PETSC   OFF  CACHE STRING "Use petsc installation")
SET(PETSC_DIR   ""   CACHE STRING "Petsc dir value (must end with slash)")
SET(PETSC_ARCH  ""   CACHE STRING "Petsc arch value")


# default variables
set(INSTALL_DIR "${CMAKE_BINARY_DIR}")


message(STATUS "------------------------------------------------------")
message(STATUS "LIBRARY_NAME          = ${LIBRARY_NAME}")
message(STATUS "LIBRARY_VERSION       = ${LIBRARY_VERSION}")
message(STATUS "CMAKE_INSTALL_PREFIX  = ${CMAKE_INSTALL_PREFIX}")
message(STATUS "USE_PETSC             = ${USE_PETSC}")
message(STATUS "------------------------------------------------------")

# --------------------------------------------------------------------

message(STATUS "PATH=$ENV{PATH}")
message(STATUS "MPI_C_LIBRARIES=${MPI_C_LIBRARIES}")
message(STATUS "MPI_C_INCLUDE_PATH=${MPI_C_INCLUDE_PATH}")
find_package(MPI REQUIRED)


# if set we use petsc installation
# otherwise we try to look for system libraries of blas and lapack
include(FindBlasLapack)

# print what we found
message(STATUS "BLAS_LIBRARIES = ${BLAS_LIBRARIES}")
message(STATUS "LAPACK_LIBRARIES = ${LAPACK_LIBRARIES}")



# set petsc arch based on CMAKE_BUILD_TYPE
#     linux-Debug or linux-Release
SET(MAKE_NUMCPUS    2)
set(PETSC_EXPORT_LIST
  MPIFC_SHOW MPICXX_SHOW MPICC_SHOW CC FC CC_FLAGS PCC_FLAGS FC_FLAGS CPP_FLAGS
  METIS_INCLUDE BLASLAPACK_INCLUDE PARMETIS_INCLUDE MUMPS_INCLUDE
  MPI_LIB MUMPS_LIB METIS_LIB PARMETIS_LIB BLASLAPACK_LIB SCALAPACK_LIB
  UMFPACK_LIB)


find_package(PETSc 3.6.0 REQUIRED)


set(BLOPEX_DIR ${CMAKE_INSTALL_PREFIX}/blopex/)
set(BLOPEX_ROOT ${BLOPEX_DIR})
include(Install/Blopex)

set(BDDCML_DIR ${CMAKE_INSTALL_PREFIX}/bddcml/)
set(BDDCML_ROOT ${BDDCML_DIR})
include(Install/BDDCML)

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

cmake_minimum_required(VERSION 2.8)

project(BDDCML CXX C Fortran)
set(EXTRAS ${CMAKE_SOURCE_DIR}/../_CMake)
set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")
set(CMAKE_MODULE_PATH "${EXTRAS}/Modules" "${CMAKE_MODULE_PATH}")

set(BDDCML_VERSION_MAJOR "2")
set(BDDCML_VERSION_MINOR "4")
set(BDDCML_VERSION_PATCH "0")
set(BDDCML_VERSION "${BDDCML_VERSION_MAJOR}.${BDDCML_VERSION_MINOR}.${BDDCML_VERSION_PATCH}")

# default variables
SET(INSTALL_DIR "${CMAKE_BINARY_DIR}")


# This value can set be using makefile
SET(USE_PETSC   Off                         CACHE STRING "Use petsc installation")
SET(PETSC_DIR   "/usr/lib/petsc/"           CACHE STRING "Petsc dir value (must end with slash)")
SET(PETSC_ARCH  "linux-${CMAKE_BUILD_TYPE}" CACHE STRING "Petsc arch value")

# if set we use petsc installation 
# otherwise we try to look for system libraries of blas and lapack
include(FindBlasLapack)

# print what we found
message(STATUS "BLAS_LIBRARIES = ${BLAS_LIBRARIES} ")
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
find_package(MPI REQUIRED)


set(BLOPEX_DIR ${INSTALL_DIR}/blopex/${CMAKE_BUILD_TYPE})
set(BLOPEX_ROOT ${BLOPEX_DIR})
include(Install/Blopex)

set(BDDCML_DIR ${INSTALL_DIR}/bddcml/${CMAKE_BUILD_TYPE})
set(BDDCML_ROOT ${BDDCML_DIR})
include(Install/BDDCML)


# add install rule, for now we copy everything in src dir
install(
	DIRECTORY ${BLOPEX_DIR}/
	DESTINATION lib/bddcml_blopex/blopex/${CMAKE_BUILD_TYPE}
)

install(
	DIRECTORY ${BDDCML_DIR}/
	DESTINATION lib/bddcml_blopex/bddcml/${CMAKE_BUILD_TYPE}
)
    
# CPack configuration 
# SET(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
SET(CPACK_PACKAGE_FILE_NAME "BDDCML_${BDDCML_VERSION}")
SET(CPACK_GENERATOR "DEB;TGZ;ZIP")
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jan Hybs") #required
INCLUDE(CPack)
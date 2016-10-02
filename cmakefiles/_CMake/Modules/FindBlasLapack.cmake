# simple module which find blas and lapack library
# using petsc installation if USE_PETSC is set
# otherwise using find_package(BLAS) and find_package(LAPACK)

if(USE_PETSC)
  SET(MAKE_NUMCPUS    2)
  set(PETSC_EXPORT_LIST MPIFC_SHOW MPICXX_SHOW MPICC_SHOW CC FC CC_FLAGS PCC_FLAGS FC_FLAGS CPP_FLAGS
  METIS_INCLUDE BLASLAPACK_INCLUDE PARMETIS_INCLUDE MUMPS_INCLUDE
  MPI_LIB MUMPS_LIB METIS_LIB PARMETIS_LIB BLASLAPACK_LIB SCALAPACK_LIB
  UMFPACK_LIB)
  find_package(PETSc 3.6.0 REQUIRED)
  
  # export variables
  set(BLAS_LIBRARIES ${PETSC_VAR_BLASLAPACK_LIB})
  set(LAPACK_LIBRARIES ${PETSC_VAR_BLASLAPACK_LIB})
else()
  # find blas
  set(BLA_STATIC On)
  find_package(BLAS REQUIRED)

  # find lapack
  set(LAPACK_STATIC On)
  find_package(LAPACK REQUIRED)
endif()
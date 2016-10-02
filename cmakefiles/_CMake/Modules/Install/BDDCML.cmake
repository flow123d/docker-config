

SET(INSTALL_URL "http://flow.nti.tul.cz/libraries/bddcml-2.4.tar.gz")
set(MAKE_INC ${INSTALL_DIR}/bddcml_make_inc)
set(FC_MAGLE_INCLUDE ${BDDCML_DIR})

# setup external project with target bddcml-lib
include(ExternalProject)
ExternalProject_Add(bddcml-lib
    DOWNLOAD_DIR        ${INSTALL_DIR} 
    URL                 ${INSTALL_URL}
    SOURCE_DIR          ${BDDCML_DIR}
    BINARY_DIR          ${BDDCML_DIR}
    
    PATCH_COMMAND patch ${BDDCML_DIR}/src/f_symbol.h ${EXTRAS}/Patches/f_symbol.h.patch
    
    CONFIGURE_COMMAND   cp ${MAKE_INC} ${BDDCML_DIR}/make.inc && cp ${INSTALL_DIR}/FC_Magle.h ${BDDCML_DIR}/FC_Magle.h
    BUILD_COMMAND       make -j 1 all
    INSTALL_COMMAND     ""
)

set(MPI_Fortran_COMPILER        ${PETSC_VAR_FC} )
set(MPI_Fortran_COMPILE_FLAGS   ${PETSC_VAR_FC_FLAGS} )
set(BDDCML_Fortran_COMPILER     ${PETSC_VAR_FC})
set(BDDCML_Fortran_FLAGS        ${PETSC_VAR_FC_FLAGS})

set(MPI_C_COMPILER              ${PETSC_VAR_CC})
set(MPI_C_COMPILE_FLAGS         ${PETSC_VAR_CC_FLAGS})

set(Parmetis_INCLUDES           ${PETSC_VAR_PARMETIS_INCLUDE})
set(Metis_INCLUDES              ${PETSC_VAR_METIS_INCLUDE})
set(Mumps_INCLUDES              ${PETSC_VAR_MUMPS_INCLUDE})

set(Mumps_LIBRARIES             ${PETSC_VAR_MUMPS_LIB})
set(ScaLAPACK_LIBRARIES         ${PETSC_VAR_SCALAPACK_LIB})
set(BLAS_LAPACK_LIBRARIES       ${PETSC_VAR_BLASLAPACK_LIB})
set(Parmetis_LIBRARIES          ${PETSC_VAR_PARMETIS_LIB})
set(Metis_LIBRARIES             ${PETSC_VAR_METIS_LIB})


include(FortranCInterface)
FortranCInterface_HEADER(${INSTALL_DIR}/FC_Magle.h MACRO_NAMESPACE FC_SYMBOL)

configure_file(
    ${EXTRAS}/Templates/bddcml_make_inc.template
    ${MAKE_INC}
    @ONLY)

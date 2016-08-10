#!/bin/bash
cd @INSTALL_DIR@/src

# by default petsc will found default system libs such as blas lapack or openmpi
./configure \
        PETSC_ARCH=@PETSC_ARCH@ \
        --download-metis=yes --download-parmetis=yes \
        --with-debugging=1 --with-shared-libraries=0 \
        --with-make-np @MAKE_NUMCPUS@ --CFLAGS="-O3 -DNDEBUG" --CXXFLAGS="-O3 -DNDEBUG -Wall -Wno-unused-local-typedefs -std=c++11"

# other options
# --with-mpi-dir=@MPI_DIR@ \
# --with-cc=@CMAKE_C_COMPILER@ --with-cxx=@CMAKE_CXX_COMPILER@ --with-fc=@CMAKE_Fortran_COMPILER@ 
# --download-fblaslapack --download-mpich 
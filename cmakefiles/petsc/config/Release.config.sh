#!/bin/bash
unset MAKEFLAGS
./configure \
        PETSC_ARCH=@PETSC_ARCH@ \
        --prefix=@PETSC_DIR@ \
        --download-metis=yes --download-parmetis=yes \
        --download-blacs=yes --download-scalapack=yes \
        --download-mumps=yes --download-hypre=https://github.com/hypre-space/hypre/archive/v2.12.0.tar.gz \
        --with-debugging=0 --with-shared-libraries=1 \
        --with-make-np @MAKE_NUMCPUS@ \
        --CFLAGS="-O3" \
        --CXXFLAGS="-O3 -Wall -Wno-unused-local-typedefs -std=c++11" @CONFIGURE_OPTS@

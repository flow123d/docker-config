# Building libraries used by Flow123d 

Build is described by the dodo.py file using doit task management system.
Point is to have parametrized build workflow with correct cacching which seems to be very impractical to do with fil focused make system.

This folder contains makefiles and files for the building process that is started calling `make  all`. 
Expects IMAGES_VERSION environment variable (part of the building container).

Particular versions of libraries is fixed for one IMEAGES_VERSION, 
the repository should be tagged for particular IMAGES_VERISON.

The build images are prepared for both g++ and clang compilers in recent versions, however
in general one could link code produced by different compilers.

Resulting library packages are stored in ../packages, i.e. the root build directory.


## Dependencies

Yaml-cpp : -
MPICH:     -
Armadillo: blas, lapack
Petsc:     blas, lapack, mpich (or other MPI lib)
BDDCML:    metis, parmetis, blacs, sclapack, mumps (all taken from Petsc)


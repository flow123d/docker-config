# docker-config
Docker files for various docker images used in Flow123d developement


To build an aimage wirh specific lib version, do the following:
```
docker build \
    --tag 3.0.9
    --build-arg VERSION_PETSC=3.14.1 \
    -f multiarch.Dockerfile .
```

All arguments:
```
DEFAULT_UBUNTU=20.04
DEFAULT_GCC=/usr/bin/gcc-6
DEFAULT_GXX=/usr/bin/g++-6
DEFAULT_CXX=/usr/bin/clang++
DEFAULT_MPICC=gcc
DEFAULT_MPICXX=g++

BUILD_TYPE=Debug

VERSION_MPICH=3.2.0
VERSION_YAMLCPP=0.5.2
VERSION_PETSC=3.8.3
VERSION_ARMADILLO=8.3.4
VERSION_BDDCML=2.5.0
VERSION_YAMLCPP=0.6.3
```

See [multiarch.Dockerfile](multiarch.Dockerfile) for more details
# docker-config
Docker files for various docker images used in Flow123d developement


To build an aimage wirh specific lib version, do the following:
```java
docker build \
    --tag 3.0.9 \
    --build-arg VERSION_PETSC=3.14.1 \
    -f multiarch.Dockerfile .
```

All arguments:
```Dockerfile
ARG DEFAULT_UBUNTU=20.04
ARG DEFAULT_GCC=/usr/bin/gcc-6
ARG DEFAULT_GXX=/usr/bin/g++-6
ARG DEFAULT_CXX=/usr/bin/clang++
ARG DEFAULT_MPICC=gcc
ARG DEFAULT_MPICXX=g++

ARG BUILD_TYPE=Debug

ARG VERSION_MPICH=3.2.0
ARG VERSION_YAMLCPP=0.5.2
ARG VERSION_PETSC=3.8.3
ARG VERSION_ARMADILLO=8.3.4
ARG VERSION_BDDCML=2.5.0
ARG VERSION_YAMLCPP=0.6.3
```

See [multiarch.Dockerfile](multiarch.Dockerfile) for more details

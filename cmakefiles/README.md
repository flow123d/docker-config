# Libs structure
<pre>
├── <strong>armadillo</strong> library:
│   └── usr
│       ├── include
│       │   └── armadillo
│       ├── lib
│       │   └── armadillo
│       └── share
│           └── armadillo
├── <strong>bddcml</strong> library:
│   └── usr
│       └── lib
│           ├── bddcml
│           └── blopex
├── <strong>petsc</strong> library:
│   └── usr
│       └── lib
│           └── petsc
└── <strong>yamlcpp</strong> library:
    └── usr
        ├── include
        │   └── yaml-cpp
        └── lib
            └── yaml-cpp
</pre>

---

## Yaml-cpp library ![info](https://img.shields.io/badge/yaml--cpp--0.5.2-612 kB / 38 files-blue.svg)

### Depends on:
 - *no dependencies*

### Deb package content
 - `/usr/include/yaml-cpp/`
 - `/usr/lib/yaml-cpp/`

---

## Armadillo library ![info](https://img.shields.io/badge/armadillo--3.4.3-309 kB / 340 files-blue.svg)

### Depends on:
 - system dev installation of `blas` and `lapack`

### Deb package content
 - `/usr/include/armadillo/`
 - `/usr/lib/armadillo/`
 - `/usr/share/armadillo/`


## Petsc library ![info](https://img.shields.io/badge/petsc--3.6.1-110 MB / 22k files-blue.svg)

### Depends on:
 - system dev installation of `blas`, `lapack` and mpi lib (`mpich` or `openmpi`)

### Deb package content
 - `/usr/lib/petsc/`

## BDDCML and Blopex library ![info](https://img.shields.io/badge/bddcml--2.4.0-1.1 MB / 386 files-blue.svg)

### Depends on:
 - system dev installation of `blas` and `lapack`
 - petsc installation with `metis`, `parmetis`, `blacs`, `scalapack`, `mumps`

### Deb package content
 - `/usr/lib/bddcml/`
 - `/usr/lib/blopex/`


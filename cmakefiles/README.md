# Libs structure
<pre>
/usr/lib
    ├── <strong>armadillo</strong>
    │   ├── include
    │   ├── lib
    │   └── share
    ├── <strong>bddcml_blopex</strong>
    │   ├── bddcml
    │   └── blopex
    ├── <strong>yamlcpp</strong>
    │   ├── include
    │   └── lib
    └── <strong>petsc</strong>

</pre>

---

## Yaml-cpp library ![info](https://img.shields.io/badge/yaml--cpp--0.5.2-612 kB / 38 files-blue.svg)

### Depends on:
 - *no dependencies*

### Deb package content
 - `/usr/lib/yamlcpp/lib`
 - `/usr/lib/yamlcpp/include`

---

## Armadillo library ![info](https://img.shields.io/badge/armadillo--3.4.3-309 kB / 340 files-blue.svg)

### Depends on:
 - system dev installation of `blas` and `lapack`

### Deb package content
 - `/usr/lib/armadillo/lib`
 - `/usr/lib/armadillo/include`
 - `/usr/lib/armadillo/share`


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
 - `/usr/lib/bddcml_blopex/bddcml/`
 - `/usr/lib/bddcml_blopex/blopex/`


# Libs structure
```
/usr/local
    ├── mpich-3.2.0
    │   ├── include
    │   ├── lib
    │   └── share
    │   └── bin
    ├── armadillo-8.4.3
    │   ├── include
    │   ├── lib
    │   └── share
    ├── bddcml-2.5.0
    │   ├── bddcml
    │   └── blopex
    ├── yamlcpp-0.5.2
    │   ├── include
    │   └── lib
    └── petsc-3.8.3
        ├── include
        ├── lib
        ├── bin
        └── share
```

---

## MPICH (3.2.0) library

#### Depends on:
 - *no dependencies*

---

## Yaml-cpp (0.5.2) library

#### Depends on:
 - *no dependencies*

---

## Armadillo (8.3.4) library

#### Depends on:
 - system dev installation of `blas` and `lapack`

---

## Petsc (3.8.3) library

#### Depends on:
 - system dev installation of `blas`, `lapack` and mpi lib (`mpich` or `openmpi`)

---

## BDDCML (2.5.0) and Blopex library

#### Depends on:
 - system dev installation of `blas` and `lapack`

or
 - petsc installation with `metis`, `parmetis`, `blacs`, `scalapack`, `mumps`

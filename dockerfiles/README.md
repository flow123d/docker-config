# Dockerfile structure
Simple scheme where dependencies are shown:
```
└── base
    ├── base-build
    │   ├── flow-libs-dev-dbg
    │   └── flow-libs-dev-rel
    └── flow-libs
        └── flow123-install
```

# Active images
## Dockerfile  `flow123d/base` ![base](https://img.shields.io/badge/base-200.8 MB / 4 layers / ~1 min-blue.svg)
 - Contains minimal libs and packages. This image is ancestor for all other images and originates from `ubuntu:16.04`.
 - What is installed:
   - `make, wget, python`


## Dockerfile `flow123d/base-build` ![base-build](https://img.shields.io/badge/base--build-881.3 MB / 6 layers / ~8 min-blue.svg)
 - Image for building other libraries. Originates from `flow123d/base`
 - *note*: big image size is cause be full latex environment
 - What is installed:
   - `cmake, git, python, python-dev, python-pip`
     `valgrind, perl, gfortran, gcc, g++, (texlive-full disabled)`
   - `libblas-dev, liblapack-dev, libmpich-dev, libopenmpi-dev`
   - `libboost`:
     - `libboost-program-options-dev`
     - `libboost-serialization-dev`
     - `libboost-regex-dev`
     - `libboost-filesystem-dev`
   - `python pip`:
     - `pyyaml`
     - `markdown`
     - `psutil`


# Inactive images
## Dockerfile `flow123d/flow-libs-dev-dbg` ![flow-libs-dev-dbg](https://img.shields.io/badge/flow--libs--dev--dbg-4.8 GB / 0 layers / ~0 min-lightgrey.svg)
 - Image is not active. In future it will server as image having all libs and packages, that software flow123d can be easily build.


## Dockerfile `flow123d/flow-libs-dev-rel` ![flow-libs-dev-rel](https://img.shields.io/badge/flow--libs--dev--rel-4.8 GB / 0 layers / ~0 min-lightgrey.svg)
 - Image is not active. In future it will server as image having all libs and packages, that software flow123d can be easily build and packed.


## Dockerfile `flow123d/flow-libs` ![flow-libs](https://img.shields.io/badge/flow--libs-200.8 MB / 0 layers / ~0 min-lightgrey.svg)
 - Image is not active. In future it will server as image having all libs and packages in **/usr** folder installed. Image will be able to run flow123d


## Dockerfile `flow123d/flow-libs-install` ![flow-libs-install](https://img.shields.io/badge/flow--libs--install-200.8 MB / 0 layers / ~0 min-lightgrey.svg)
 - Image is not active. In future it will server as image having all libs and packages in **/usr** folder installed and also release version of flow123d inside along with helper scripts. This will be deploy image distributed to end users.

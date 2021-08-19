# Docker images for the project Flow123d
Repository contains rules and Dockerfiles to prepare various Docker images used in 
the [Flow123d](https://github.com/flow123d/flow123d) development and continuous integration.


## Resulting Images (to be updated):  
  -  [`flow123d/base-gnu`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/base-gnu) 
     [![](https://images.microbadger.com/badges/image/flow123d/base.svg)](https://microbadger.com/images/flow123d/base-gnu "analysed by microbadger")
     Auxiliary base of all gnu images.
     
   -  [`flow123d/base-intel`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/base-gnu) 
     [![](https://images.microbadger.com/badges/image/flow123d/base.svg)](https://microbadger.com/images/flow123d/base-gnu "analysed by microbadger")
     Auxiliary base of all intel images.
   
  -  [`flow123d/base-build-gnu`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/base-build-gnu)
     [![](https://images.microbadger.com/badges/image/flow123d/build-base.svg)](https://microbadger.com/images/flow123d/base-build-gnu "analysed by microbadger")
     FROM: `base-gnu`
     Auxiliary base of the development gnu images. Contains common build tools: compilers, cmake, git, valgrind, ...
     
  -  [`flow123d/base-build-intel`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/base-build-intel)
     [![](https://images.microbadger.com/badges/image/flow123d/build-base.svg)](https://microbadger.com/images/flow123d/base-build-intel "analysed by microbadger")
     FROM: `base-intel`
     Auxiliary base of the development intel images. Contains common build tools: compilers, cmake, git, valgrind, ...

  -  [`flow123d/lib-build-base-TYPE`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/lib-build-base)
     [![](https://images.microbadger.com/badges/image/flow123d/lib-build-base.svg)](https://microbadger.com/images/flow123d/lib-build-base "analysed by microbadger")
     FROM: `build-base`
     Auxiliary image for building necessary libraries for Flow123d.

  -  [`flow123d/flow-libs-dev-TYPE`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/flow-libs-dev-dbg) 
     [![](https://images.microbadger.com/badges/image/flow123d/flow-libs-dev-dbg.svg)](https://microbadger.com/images/flow123d/flow-libs-dev-dbg "analysed by microbadger")
     FROM: `build-base`, copy from: `lib-build-base`
     Debug development image.
     
  -  [`flow123d/flow-libs-dev-TYPE`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/flow-libs-dev-rel) 
     [![](https://images.microbadger.com/badges/image/flow123d/flow-libs-dev-rel.svg)](https://microbadger.com/images/flow123d/flow-libs-dev-rel "analysed by microbadger")
     **depends on**: lib-build-base, release libraries
     FROM: `build-base`, copy from: `lib-build-base`
     Release development image.
     
  -  [`flow123d/install`](https://github.com/janhybs/flow123d-docker-images/tree/master/dockerfiles/install) 
     [![](https://images.microbadger.com/badges/image/flow123d/install.svg)](https://microbadger.com/images/flow123d/install "analysed by microbadger")
     FROM: `base`, copy from: lib-build-base-rel
     Base of release images.
     

How to build new images?

1. Set new version of images, according to the first Flow123d version that will use them.

    ```
    makefile: images_version=X.Y.Z
    ```

2. Download source packages for own build libraries (YAMLCPP, Armadillo, MPICH, PETSC, BDDCML), 
   upload them to: `astra.nti.tul.cz/Projekty/Modelari/flow123d/libraries`

3. Modify `dockerfiles` for the images,
   in particular set lib versions in: `dockerfiles/flow-libc`, `dockerfiles/flow-libs-dev`, and `dockerfiles/install-base`
   

4. Upload images (flow-libs-dev-TYPE, install):

    ```
    docker push flow123d/IMAGE_NAME:VERSION
    ```
    
5. Update `config.default.cmake` in flow123d.

6. Try to build flow123d:
    ```
    bin/fterm dbg @VERSION
    make all
    ```
    and release build:
    ```
    bin/fterm dbg @VERSION
    make all
    ```
7. Fix Jenkins CI build: `ciflow.nti.tul.cz:8080/`
   Update configuration.
   
8. Fix package builds.
    
9. Mark images as *latest*, (possibly deprecated, no need for the latest, but latest is default version for the docker)

    docker tag flow123d/IMAGE_NAME:VERSION flow123d/IMAGE_NAME:latest

10. Check all processes again.
     



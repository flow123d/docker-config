# Docker images for the project Flow123d
Repository contains rules and Dockerfiles to prepare various Docker images used in 
the [Flow123d](https://github.com/flow123d/flow123d) development and continuous integration.


## Resulting Images (to be updated):  
  -  [`flow123d/base-gnu`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/base-gnu) 
     Auxiliary base of all gnu images.

   -  [`flow123d/base-intel`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/base-intel) 
     Auxiliary base of all intel images.

  -  [`flow123d/base-build-gnu`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/base-build-gnu)
     FROM: `base-gnu`
     Auxiliary base of the development gnu images. Contains common build tools: compilers, cmake, git, valgrind, ...

  -  [`flow123d/base-build-intel`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/base-build-intel)
     FROM: `base-intel`
     Auxiliary base of the development intel images. Contains common build tools: compilers, cmake, git, valgrind, ...

  -  [`flow123d/libs-gnu`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/libs-gnu)
     FROM: `base-build-gnu`
     Auxiliary image for building necessary libraries for Flow123d and GNU environment.

  -  [`flow123d/libs-intel`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/libs-intel)
     FROM: `base-build-intel`
     Auxiliary image for building necessary libraries for Flow123d and Intel environment.

  -  [`flow123d/flow-dev-gnu`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/flow-dev-gnu) 
     **depends on**: libs-gnu, release libraries
     FROM: `base-build-gnu`
     Debug development image.

  -  [`flow123d/flow-dev-intel`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/flow-dev-intel) 
     **depends on**: libs-intel, release libraries
     FROM: `base-build-intel`
     Release development image.

  -  [`flow123d/install-gnu`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/install-gnu) 
     FROM: `base-gnu`
     Base of release images for GNU.

  -  [`flow123d/install-intel`](https://github.com/flow123d/docker-config/tree/master/dockerfiles/install-intel) 
     FROM: `base-gnu`
     Base of release images for Intel.

     

How to build new images?

1. Set new version of images, according to the first Flow123d version that will use them.

    ```
    makefile: images_version=X.Y.Z
    ```

2. Download source packages for own build libraries (YAMLCPP, Armadillo, MPICH, PETSC, BDDCML), 
   upload them to: `astra.nti.tul.cz/Projekty/Modelari/flow123d/libraries`

3. Modify `dockerfiles` for the images,
   in particular set lib versions in: `dockerfiles/flow-libc`, `dockerfiles/flow-libs-dev`, and `dockerfiles/install-gnu`
   

4. Upload images (flow-dev-gnu-TYPE, install):

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
     



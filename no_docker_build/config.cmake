# Configuration for metacentrum
set(FLOW_BUILD_TYPE release)
set(CMAKE_VERBOSE_MAKEFILE on)

# external libraries
set(PETSC_DIR           "/storage/brno2/home/jan_brezina/flow123d_build/flow123d_libs/petsc/")
set(PETSC_ARCH          "linux-Release")

set(BDDCML_ROOT         "/storage/brno2/home/jan_brezina/flow123d_build/flow123d_libs/bddcml/bddcml/Release")
set(YamlCpp_ROOT_HINT   "/storage/brno2/home/jan_brezina/flow123d_build/flow123d_libs/yamlcpp/Release")
set(Armadillo_ROOT_HINT "/storage/brno2/home/jan_brezina/flow123d_build/flow123d_libs/armadillo/Release")


# additional info
set(USE_PYTHON          "yes")
set(PLATFORM_NAME       "linux_x86_64")

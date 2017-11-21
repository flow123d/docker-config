#!/bin/bash
#
# build-libs.sh <INSTALL_PREFIX> <FLOW123D_ROOT>
#
# TODO:
# - it seems that internal cmake build step performed by individual libraries,  e.g. YAMLCPP, PUGIXML, do not se compiler 
#   loaded through module (gcc7.2.0 in this case) but use default compiler (gcc 4.8.1). Only Armadillo seems to use the right compiler
#   possibly due to unloading gcc 4.8.1.
# - we risk problems since used module openmpi use gcc 4.8.1, and we force it to provide wrapper (mpicc) for gcc 7.2.0. 
#
# - remove intermediate makefiles for individual libraries, call cmake directly
# - remove usage of CMAKE external project (unecessary compiler etc detection, boilerplate directories), use wget or curl (both available in metacentrum) directly to download the project
# - install all libraries to an install prefix as well as the Flow123d itself
# - Is it possible to move libraries after that? Using ORIGIN, it would be possible provided the realitive path remains the same, so the whole prefix can move.
# - Use shared libs.

# specify location where libs will be build and installed
INSTALL_PREFIX="${1:-${HOME}/local}"
mkdir -p $INSTALL_PREFIX


# set dir of cmakefiles current dir manually because when using qsub, location is elsewhere
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# location of the flow123d
FLOW_ROOT="${2:-"${DIR}/../../.."}"


NJOBS=${NJOBS:-8}

_SEP_="--------------------------------------------------------------------------"


# ------------------------------------------------------------------------------
# ----------------------------------------------------------------- MODULES ----
# ------------------------------------------------------------------------------
# common modules
mod_cmake=cmake-3.6.1
#mod_cxx=gcc-7.2.0
#mod_cxx=gcc-6.4.0
mod_cxx=gcc-4.9.2

mod_mpi=openmpi
mod_python3=python-3.6.2-gcc
python3_root=/software/python-3.6.2

#module load boost-1.56-gcc
#module load perl-5.20.1-gcc

#module load python27-modules-gcc
#module load python-3.6.2-gcc 
#module load python36-modules-gcc      # version 2.7.10-gcc has issue when importing hashlib 
                                  # > python
                                  # import hashlib
                                  # <ERROR>
                                  
#module unload gcc-4.8.1
#module unload openmpi-1.8.2-gcc



function print_build_header() {
    echo $_SEP_
    echo "Building library: ${LIB_NAME}"
    echo "build type: $BUILD_TYPE"
    echo "build dir : $BUILD_TREE"    
    echo $_SEP_
}

function load_modules() {
    module purge
    module load metabase
    for m in $@
    do
        module load $m
    done
    echo "Modules:"
    module list
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------ YAML-CPP LIB ----
# ------------------------------------------------------------------------------
function build_yaml_cpp() {
    LIB_NAME="YAML-CPP"
    BUILD_TYPE=Release
    BUILD_TREE=$INSTALL_PREFIX/yamlcpp
    print_build_header
    
    if [ ! -d ${BUILD_TREE} ]
    then
        load_modules $mod_cmake $mod_cxx     
        export NJOBS
        make -C $DIR/yamlcpp \
            BUILD_TYPE=$BUILD_TYPE \
            BUILD_TREE=$BUILD_TREE \
            build
    fi
    
    # fix installation, since flow123d FindYamlCPP expect .a file
    # to be in lib folder, we do it manually without package call
    #mkdir -p $BUILD_TREE/$BUILD_TYPE/lib
    #cp $BUILD_TREE/$BUILD_TYPE/libyaml-cpp.a $BUILD_TREE/$BUILD_TYPE/lib/libyaml-cpp.a
    export LIB_YAMLCPP="$BUILD_TREE/$BUILD_TYPE"
    
}


# ------------------------------------------------------------------------------
# ------------------------------------------------------------ PUGIXML LIB ----
# ------------------------------------------------------------------------------
function build_pugixml() {
    LIB_NAME="PugiXML"
    BUILD_TYPE=Release
    BUILD_TREE=$INSTALL_PREFIX/pugixml
    print_build_header
    
    if [ ! -d ${BUILD_TREE} ]
    then
        load_modules $mod_cmake $mod_cxx     
        export NJOBS
        make -C $DIR/pugixml \
            BUILD_TYPE=$BUILD_TYPE \
            BUILD_TREE=$BUILD_TREE \
            build
    fi
    
    # fix usage without installation; copy header
    mkdir $BUILD_TREE/$BUILD_TYPE/include
    cp $BUILD_TREE/$BUILD_TYPE/src/*.hpp $BUILD_TREE/$BUILD_TYPE/include
    mkdir $BUILD_TREE/$BUILD_TYPE/lib
    cp $BUILD_TREE/$BUILD_TYPE/*.a $BUILD_TREE/$BUILD_TYPE/lib
    export LIB_PUGIXML="$BUILD_TREE/$BUILD_TYPE"
    
}




# ------------------------------------------------------------------------------
# --------------------------------------------------------------- PETSC LIB ----
# ------------------------------------------------------------------------------
function build_petsc() {
    LIB_NAME="PETSC"
    BUILD_TYPE=Release
    BUILD_TREE=$INSTALL_PREFIX/petsc
    
    print_build_header

    if [ ! -d ${BUILD_TREE} ]
    then

        load_modules $mod_cmake $mod_mpi $mod_cxx $mod_fortran  python-2.7.10-gcc
        module unload gcc-4.8.1 # due to openmpi        
        cfg_template="petsc_cfg_${BUILD_TYPE}_template"
        cp ${cfg_template} ./petsc
        # call cmake directly
        SOURCE_TREE="$(pwd)/petsc"
        mkdir -p ${BUILD_TREE}
        cd ${BUILD_TREE} 
        cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
            -DCONFIG_TEMPLATE="${cfg_template}" \
            -DNJOBS=${NJOBS}  ${SOURCE_TREE}
        make petsc-lib
    fi    
   
    export PETSC_DIR="$INSTALL_PREFIX/petsc/src"
    export PETSC_ARCH="linux-$BUILD_TYPE"
}

# ------------------------------------------------------------------------------
# ----------------------------------------------------------- ARMADILLO LIB ----
# ------------------------------------------------------------------------------
function build_armadillo() {
    # default build type
    LIB_NAME=Armadillo
    BUILD_TYPE=Release
    USE_PETSC=On
    # default location for building
    BUILD_TREE=$INSTALL_PREFIX/armadillo
    export PETSC_DIR="$INSTALL_PREFIX/petsc/src"
    export PETSC_ARCH="linux-$BUILD_TYPE"

    print_build_header

    if [ ! -d ${BUILD_TREE} ]
    then

        load_modules $mod_cmake $mod_cxx $mod_mpi   # mpi due to PETSC test
        module unload gcc-4.8.1 # due to openmpi


        make -C $DIR/armadillo \
            BUILD_TYPE=$BUILD_TYPE \
            BUILD_TREE=$BUILD_TREE \
            USE_PETSC=$USE_PETSC \
            PETSC_DIR=$PETSC_DIR \
            PETSC_ARCH=$PETSC_ARCH \
            build
    fi
    
    export LIB_ARMADILLO="$BUILD_TREE/$BUILD_TYPE"
}


# ------------------------------------------------------------------------------
# -------------------------------------------------------------- BDDCML LIB ----
# ------------------------------------------------------------------------------
function build_bddcml() {
    # default build type
    LIB_NAME=BDDCML
    BUILD_TYPE=Release
    USE_PETSC=On
    # default location for building
    BUILD_TREE=$INSTALL_PREFIX/bddcml
    export PETSC_DIR="$INSTALL_PREFIX/petsc/src"
    export PETSC_ARCH="linux-$BUILD_TYPE"

    print_build_header

    if [ ! -d ${BUILD_TREE} ]
    then

        load_modules $mod_cmake $mod_cxx $mod_mpi   # mpi due to PETSC test
        module unload gcc-4.8.1 # loade by openmpi; gcc-4.8.1 have problem with restrict qualifier


        make -C $DIR/bddcml \
            BUILD_TYPE=$BUILD_TYPE \
            BUILD_TREE=$BUILD_TREE \
            USE_PETSC=$USE_PETSC \
            PETSC_DIR=$PETSC_DIR \
            PETSC_ARCH=$PETSC_ARCH \
            build
    fi
    export LIB_BDDCML="$BUILD_TREE/bddcml/$BUILD_TYPE"
}


function make_flow_config() {
#     echo "# Configuration for metacentrum"    >  config.cmake
#     echo "set(FLOW_BUILD_TYPE release)"       >> config.cmake
#     echo "set(CMAKE_VERBOSE_MAKEFILE on)"     >> config.cmake
#     echo "set(LIBS_ROOT $INSTALL_PREFIX)"     >> config.cmake
#     echo "set(LIB_BUILD_TYPE Release)"        >> config.cmake
    cat <<EOT > config.cmake
    # external libraries
    set(PETSC_DIR           "$PETSC_DIR")
    set(PETSC_ARCH          "$PETSC_ARCH")

    # set(BDDCML_ROOT         "$LIB_BDDCML")
    set(YamlCpp_ROOT_HINT   "$LIB_YAMLCPP")
    set(PugiXml_ROOT_HINT   "$LIB_PUGIXML")
    set(Armadillo_ROOT_HINT "$LIB_ARMADILLO")
    set(USE_PYTHON          "yes")
    set(PYTHON_LIBRARY "$python3_root/gcc/lib/libpython3.6m.so.1.0")
    set(PYTHON_INCLUDE_DIR "$python3_root/gcc/include/python3.6m")
    set(MAKE_NUMCPUS $NJOBS)
    set(FLOW_BUILD_TYPE release)

    set(PLATFORM_NAME       "linux_x86_64")
    set( CMAKE_CXX_COMPILER "g++")
EOT
}

function build_flow123d() {
    
    load_modules $mod_cmake $mod_cxx $mod_mpi $mod_python3 boost-1.55
    module unload python-2.7.6-gcc
    module unload gcc-4.8.1 # loade by openmpi; gcc-4.8.1 have problem with restrict qualifier
    gcc --version
    
    cp $DIR/config.cmake $FLOW_ROOT/config.cmake
    cd $FLOW_ROOT
    #git branch
    #git fetch
    #git pull origin master
    make cmake
    make -j$NJOBS VERBOSE=1 fast-flow123d


    # set permission to 777 to other people can 
    # execute files and access libs
    chmod -R 777 $FLOW_ROOT/bin
    chmod -R 777 $FLOW_ROOT/tests/runtest
    chmod -R 777 $FLOW_ROOT/build_tree/bin

    # allow access to libs
    chmod 777 $INSTALL_PREFIX/*
}


# ------------------------------------------------------------------------
# Main

build_yaml_cpp
build_pugixml

build_petsc
build_armadillo

# TODO: 
# - move instal Cmake file into bddcml sudir, possibly have just single install cmake file.
# - pass nonstandard PETSC location.
#build_bddcml
make_flow_config
build_flow123d

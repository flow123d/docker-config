#!/bin/bash
#PBS -N build-flow123d
#PBS -l mem=4gb
#PBS -l scratch=1gb
#PBS -l nodes=1:ppn=2
#PBS -l walltime=01:59:00
#PBS -j oe
# ::  qsub -l walltime=2h -l nodes=1:ppn=2,mem=4gb -I

# set current dir manually because when using qsub, location is elsewhere
DIR=/storage/praha1/home/jan-hybs/projects/docker-config/cmakefiles
# location of the flow123d
FLOW_LOC=/storage/praha1/home/jan-hybs/projects/Flow123dDocker/flow123d
# branch to be built
BRANCH=JHy_runtest_update
_SEP_="--------------------------------------------------------------------------"


# ------------------------------------------------------------------------------
# ----------------------------------------------------------------- MODULES ----
# ------------------------------------------------------------------------------
echo "Loading modules"
echo $_SEP_
module load cmake-3.6.1           # version 2.8.12 causes problem with PythonLibs
                                  # version 2.8.11 causes problem with cmake_link_script
module load gcc-4.9.2
module load boost-1.56-gcc
module load perl-5.20.1-gcc
module load openmpi

module load python27-modules-gcc
module load python-2.7.6-gcc      # version 2.7.10-gcc has issue when importing hashlib 
                                  # > python
                                  # import hashlib
                                  # <ERROR>

module unload gcc-4.8.1
module unload openmpi-1.8.2-gcc

echo "Modules loaded"
module list
echo $_SEP_


# ------------------------------------------------------------------------------
# ---------------------------------------------------------- BUILD FLOW123d ----
# ------------------------------------------------------------------------------
cp $DIR/config.cmake $FLOW_LOC/config.cmake


echo "Building project Flow123d"
echo "Build directory set to: "
echo "  $FLOW_LOC"
echo $_SEP_


make -C $FLOW_LOC -j3 all


# set permission to 777 to other people can 
# execute files and access libs
chmod -R 777 $FLOW_LOC/bin
chmod -R 777 $FLOW_LOC/tests/runtest
chmod -R 777 $FLOW_LOC/build_tree/bin

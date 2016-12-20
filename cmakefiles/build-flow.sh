#!/bin/bash
#PBS -N install-libs
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
# ---------------------------------------------------------- BUILD FLOW123d ----
# ------------------------------------------------------------------------------
cp $DIR/config.cmake $FLOW_LOC/config.cmake


echo "Building project Flow123d"
echo "Build directory set to: "
echo "  $FLOW_LOC"
echo $_SEP_


make -C $FLOW_LOC -j3 cmake
#!/bin/bash
#PBS -l select=2:ncpus=1:mem=1gb
#PBS -l walltime=02:00:00
#PBS -l place=scatter
#PBS -q charon_2h

module add mpich-3.0.2-gcc

mpirun --hostfile $PBS_NODEFILE singularity exec $PBS_O_WORKDIR/mpich.sif /tutorials/OSU-MicroBenchmarks/build.mpich/libexec/osu-micro-benchmarks/mpi/one-sided/osu_get_latency

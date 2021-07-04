#!/bin/bash
#PBS -l select=2:ncpus=1:mem=1gb
#PBS -l walltime=02:00:00
#PBS -l place=scatter
#PBS -q charon_2h

PATH=/auto/liberec3-tul/home/radeksrb/sing/mpich_psm-install/bin:$PATH ; export PATH

mpirun --hostfile $PBS_NODEFILE /auto/liberec3-tul/home/radeksrb/tutorials/OSU-MicroBenchmarks/build.mpich_psm/libexec/osu-micro-benchmarks/mpi/one-sided/osu_get_latency

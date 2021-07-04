#!/bin/bash
#PBS -l select=2:ncpus=1:mem=1gb
#PBS -l walltime=02:00:00
#PBS -l place=scatter
#PBS -q charon_2h

module add intelmpi-5.0.1

singularity exec $PBS_O_WORKDIR/oneapi_mpitest_purged2.sif bash -c "source /opt/intel/oneapi/setvars.sh && mpirun --hostfile $PBS_NODEFILE /tutorials/OSU-MicroBenchmarks/build.intel/libexec/osu-micro-benchmarks/mpi/one-sided/osu_get_latency"

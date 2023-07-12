#!/bin/bash

#SBATCH -t 03:00:00
#SBATCH -A lu2023-7-45
#SBATCH -p lu48
#SBATCH -J MNXB11-container-buildscript

# This script can be used to submit a build script to SLURM
# Edit the SBATCH entries above according to your needs

# Path where the build and apps folders will be
WORKDIR=/projects/hep/fs12/pp/pflorido/work

BUILDDIR=${WORKDIR}/build
APPS=${WORKDIR}/apps

mkdir -p $BUILDDIR $APPS

apptainer exec -B $TMPDIR:$TMPDIR -B $SLURMTMP:$SLURMTMP -B $WORKDIR:/work ~/testcontainer/mnxb11_al9-dev.0.2.sif ./build.sh


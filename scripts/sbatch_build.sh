#!/bin/bash

#SBATCH -t 03:00:00
#SBATCH -A lu2023-7-45
#SBATCH -p lu48
#SBATCH -J MNXB11-container-buildscript

# This script can be used to submit a build script to SLURM
# Edit the SBATCH entries above according to your needs

# Path where the build and apps folders will be
MNXB11_WORKDIR=/projects/hep/fs12/pp/pflorido/work

# Comment out if you have custom sources and scripts.
#MNXB11_SOURCEDIR=${MNXB11_WORKDIR}/source
MNXB11_BUILDDIR=${MNXB11_WORKDIR}/build
MNXB11_APPS=${MNXB11_WORKDIR}/apps
MNXB11_SCRIPTS=${MNXB11_WORKDIR}/scripts

mkdir -p $MNXB11_BUILDDIR $MNXB11_APPS 

# Remember to comment out the things you do not want to build in build.sh before launching this!
apptainer exec -B $TMPDIR:$TMPDIR -B $SLURMTMP:$SLURMTMP -B $MNXB11_WORKDIR:/work ~/testcontainer/mnxb11_al9-dev.0.2.sif ./build.sh


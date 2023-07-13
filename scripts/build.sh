#!/bin/bash

# This script can be used to build all software inside the container
# Comment out the build scripts that you do not want to execute.


# These should be existing paths inside the container.
# Usually you want to bind mount them with docker or apptainer
MNXB11_BUILDDIR=/work/build
MNXB11_APPS=/work/apps 

# ROOT build. The sources are already in the -dev container for now.
echo "building root..."
/opt/scripts/buildroot.sh

# Add more scripts if needed
#echo "building software"
#/opt/scripts/buildsoftware.sh

#!/bin/bash

# This script can be used to build all software inside the container

# These should be existing paths inside the container.
# Usually you want to bind mount them woth docker or apptainer
BUILDDIR=/work/build
APPS=/work/apps 

echo "building root..."
/opt/scripts/buildroot.sh

# Add more scripts if needed
#echo "building software"
#/opt/scripts/buildsoftware.s

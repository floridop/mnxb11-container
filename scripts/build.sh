#!/bin/bash

# These should be existing paths inside the container.
# Usually you want to bind mount them woth docker or apptainer
BUILDDIR=/work/build
APPS=/work/apps 

/opt/scripts/buildroot.sh


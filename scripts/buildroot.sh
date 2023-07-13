#!/bin/bash

# This script only works inside the MNXB11 container
# The paths are initialized there.
# TODO: Can be generalized by passing the ROOT version for the source path.

for var_name in MNXB11_BUILDDIR MNXB11_APPS MNXB11_SOURCEDIR; do
  if [ -z "${!var_name}" ]; then   
     echo "$var_name is not set. Please run"
     echo "   export $var_name=/path/to/dir"
     echo "before running this script. Exiting..."
     exit 1
  fi
done

exit

mkdir -p ${MNXB11_BUILDDIR}/root ${MNXB11_APPS}/root
cd ${MNXB11_BUILDDIR}/root
cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=${MNXB11_APPS}/root ${MNXB11_SOURCEDIR}/root-6.28.04/
cmake --build ${MNXB11_BUILDDIR}/root --target install


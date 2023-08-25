#!/bin/bash

# Check if the folder MNXB11_APPS exists
if [ -d "$MNXB11_APPS" ]; then
  # Loop through each subdirectory in MNXB11_APPS
  for directory in $MNXB11_APPS/*; do
    # If the 'bin' folder exists, add it to the PATH variable
    if [ -d "$directory/bin" ]; then
      # 'bin' folders contain executable programs, adding them to PATH allows
      # running them from any directory
      export PATH="$directory/bin:$PATH"
    fi

    # If the 'lib' folder exists, add it to the LD_LIBRARY_PATH variable
    if [ -d "$directory/lib" ]; then
      # 'lib' folders contain shared libraries, adding them to LD_LIBRARY_PATH
      # helps programs find required libraries during runtime
      export LD_LIBRARY_PATH="$directory/lib:$LD_LIBRARY_PATH"
    fi

    # If the 'lib64' folder exists, add it to the LD_LIBRARY_PATH variable
    if [ -d "$directory/lib64" ]; then
      # Some systems use 'lib64' to store 64-bit libraries, also added to
      # LD_LIBRARY_PATH for compatibility
      export LD_LIBRARY_PATH="$directory/lib64:$LD_LIBRARY_PATH"
    fi

    # If the 'cmake' folder exists, add it to the CMAKE_PREFIX_PATH variable
    if [ -d "$directory/cmake" ]; then
      # 'cmake' folders contain CMake configuration files for libraries and
      # projects, adding them to CMAKE_PREFIX_PATH helps CMake find dependencies
      # during the build process
      export CMAKE_PREFIX_PATH="$directory/cmake:$CMAKE_PREFIX_PATH"
    fi
    # If the 'pkgconfig' folder exists, add it to the PKG_CONFIG_PATH variable
    if [ -d "$directory/pkgconfig" ]; then
      # 'pkgconfig' folders contain metadata files used by pkg-config utility to
      # find library and compiler flags, adding them to PKG_CONFIG_PATH helps in
      # compilation and linking
      export PKG_CONFIG_PATH="$directory/pkgconfig:$PKG_CONFIG_PATH"
    fi

    if [ -d "$directory/include" ]; then
      # 'include' folders usually contain header files required for development,
      # adding them to C_INCLUDE_PATH or CPLUS_INCLUDE_PATH can help compilers
      # find headers
      export C_INCLUDE_PATH="$directory/include:$C_INCLUDE_PATH"
      export CPLUS_INCLUDE_PATH="$directory/include:$CPLUS_INCLUDE_PATH"
    fi

    if [ -d "$directory/share" ]; then
      # 'share' folders may contain data files or other resources, adding them
      # to XDG_DATA_DIRS can help applications find these resources
      export XDG_DATA_DIRS="$directory/share:$XDG_DATA_DIRS"
    fi

    # Add any other important development directories as needed here ...
  done
fi


# Run the default command or override it with any command passed as arguments
exec "$@"

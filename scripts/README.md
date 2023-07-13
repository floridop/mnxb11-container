# Scripts for mnxb11-containers

This folder contains helper scripts to build software inside the
container. In particular:

  * For each software there should exist a `buildsoftware.sh` script that has
the logic to build the specific software. Example: `buildroot.sh` builds ROOT.

  * `build.sh` sets up the environment inside the container and contains a call to each `buildsoftware.sh`
     This script can override the prebuilt variables inside the container.

  * `sbatch_build.sh` is an example sbatch file that
     * Creates the needed folders to be mounted inside the container
     * Mounts additional folders that are specific to Lunarc environment
     * Starts the a container and passes the `build.sh` script to run all the builds.

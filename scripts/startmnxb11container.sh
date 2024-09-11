#!/bin/bash

# Store the first parameter in a variable, it's the app to pass to the container
APPLICATION=$1

# Store the time of launch in a variable
TIMESTAMP=$(date --iso-8601=seconds)

# Notify about starting the container script
echo "$TIMESTAMP : Starting container script"

# This function prints out information about how to use the script
usage(){
  echo
   echo "Missing application parameter to run in the container, the container will exit immediately."
   echo "Usage:"
   echo "       $0 <applicationname>"
   echo
   echo "If you wish to start an interactive session inside the container, maybe you need to pass"
   echo "a command interpreter such as bash, example:"
   echo "       $0 bash"
   echo
}

# If no input parameters, print the usage message
if [[ "${APPLICATION}x" == "x" ]]; then
   usage
fi

# Set a better Apptainer prompt
# Taken from https://apptainer.org/docs/user/main/environment_and_metadata.html#environment-overview
export APPTAINERENV_PS1="Apptainer[\\u@\\h \\w]> "

# Start the mnxb11 container
apptainer run -B $XAUTHORITY:$XAUTHORITY -B /run/user:/run/user -B /projects:/projects /projects/hep/fs10/mnxb11/containers/mnxb11_al9.latest.sif $APPLICATION

# Update timestamp
TIMESTAMP=$(date --iso-8601=seconds)

# Notify of container stopping
echo "$TIMESTAMP : Container script exiting"

# mnxb11-container
Container dockerfiles for the MNXB11 course

If you're a student attending the course, you do not need these files. These are for the teachers
to prepare the environment.

Instead dowload the prebuilt images directly from dockerhub:

https://hub.docker.com/repository/docker/floridop/mnxb11/general

# Dockerfiles description

`Dockerfile-AL9-MNXB11`

The basic minimal Dockerfile to build the course container.  
It does not contain sources to build software.  
Only binaries and headers should be added to this container.

`Dockerfile-AL9-MNXB11-dev`

The Docker container used to build some of the software.  
It will download the sources needed and build the software at container creation time.  
You should download this if you're a teacher or a student that wants to build additional software for the container.  
It takes more time and it will generate a larger container image.

# How to build

**NOTE:** you do **not** need to build the container if you're attending the course. This is mainly for teachers.

The container follows the standard Docker build procedure described at

<https://docs.docker.com/engine/reference/commandline/build/>

## Requirements

  1. Install Docker Desktop or Docker Engine from <https://docs.docker.com/get-docker/>

If you're totally new to Docker I recommend to read <https://docs.docker.com/get-started/>

## Commands

  1. Get this repo from github:
     ```bash
     git clone https://github.com/floridop/mnxb11-container.git
     ```
  2. Cd into the repo
     ```bash
     cd mnxb11-container
     ```
  4. Run docker build on the selected container, i.e.
     ```bash
     docker build -t "mnxb11:al9.version" -f Dockerfile-AL9-MNXB11 .
     ```
  6. Wait until the build completes
  7. You can now list the build container with
     ```bash
     docker image ls
     ```
  9. You can start the container with
     ```bash
     docker run -it mnxb11:al9.version
     ```

# Teachers: procedure to add software to the container

To minimize the size of the container, we build two containers. One intended
for students and for the course, and another to build software that contains
all the sources and libraries (see section "Dockerfiles description" )

Custom software is placed in the container inside the `/opt/apps` folder.

An overview of the procedure is as follows:

  1. Clone this repository
  2. Edit `Dockerfile-AL9-MNXB11-dev` and add the required system packages and sources that you already know of.
  3. Build the `-dev` container with the new dependencies.
  4. Start the container with a bind-mount writable folder, it will be used to export the compiled binaries outside the container to an `apps` folder
  5. Inside the container, install additional required packages and additional sources needed. 
     Take note of them as you will need to add them to the Dockerfiles later!
     **NOTE:** Mind that you cannot add system packages if you do not have root access in the container, so
     this must be done in a machine where you are administrator. 
  6. Compile and install the software in the bind-mounted folder
  7. Rebuild the course container by adding the required dependencies in `Dockerfile-AL9-MNXB11` and the compiled apps in the `apps` folder.
  8. Upload the new container to dockerhub, or ask Florido to build/upload the latest you generated.
  9. Fork this repository and pull request the new version of Dockerfiles to this repository, or just send the modified Dockerfiles to Florido.

If the software compilation does not require adding system packages, step 2 can be replaced by downloading a prebuilt -dev container.

The process is described in detail below, assuming you are on a machine where you are administrator.

## 1. Clone this repo

The repo contains some scripts that can be used for the build, especially if you
want to compile software at Lunarc.

```bash
git clone https://github.com/floridop/mnxb11-container.git
cd mnxb11-container
```

## 2. Add required system packages and sources

Edit `Dockerfile-AL9-MNXB11**-dev**` and add relevant stuff in the proper folders. 

The directory structure and relative variables while doing ADD is as follows.

```bash
/opt # Main folder for all external software. Variable: MNXB11_MNXB11DIR
  /apps # Contains compiled applications, one folder per application. Variable: $MXNB11_APPS
  /build # Contains builds, one folder per application/library. Variable: $MXNB11_BUILDDIR
  /download # Contains downloaded software e.g. tarballs or such. Variable: $MXNB11_DOWNLOADS
  /scripts # Contains build scripts and other automation things for the container. Variable: $MXNB11_SCRIPTS
  /source # Contains source code, one folder per source tree. Variable: $MXNB11_SOURCEDIR
```

## 3. Build the -dev container

For this step to work you need a working docker or singularity/apptainer installation. See references at the beginning of this document.
This makes sense only on a machine where you are administrator, i.e. not at Lunarc.

```bash
docker build -t "mnxb11:al9-dev.myversion" -f Dockerfile-AL9-MNXB11-dev
```

## 4. Start the container with a bind mount

For simplicity I will assume you create a bind mount exactly in the folder
where you cloned the repo. Call it `work` and bind it as /work inside the container:

```bash
mkdir work
docker run -it -v ${PWD}/work:/work mnxb11:al9-dev.myversion
```

You will be now inside the container.

## 5. Check that all the needed to build is present in the container

You can install manually system packages inside Alma Linux with

```bash
dnf install packagename
# If you don't know the package name:
# Find a package name
dnf search packagename
# If you know the binary but not the package:
dnf provides */binaryname
```

Copy any other relevant things in the specific folders, for example additional sources or scripts.

Anything you do at this step, please take note, it will need to be added again to the dockerfile if 
you plan to share this with the rest of the teachers.

## 6. Compile and Build the software inside the container

Compile the software using the ways suggested by the software itself. I recommend to create
a script such as the `buildroot.sh` script to automate the process.

If you create such script please make sure to add it to the scripts folder in the git 
repository and send me a pull request so it can be reused. 

The resulting software should end up in the `/work/mysoftware` folder, 
and outside the container in ${PWD}/work/mysoftware on your machine

Once the compilation is done you can exit the -dev container.

## 7. Rebuild the course container

In order to build the course container with the new app, 
   7.1. copy the content of the software over in the `apps` folder
   ```bash
   cp -ar ${PWD}/work/mysoftware apps/
   ```
   7.2. Copy your custom installation scripts in the `scripts/` folder.
   7.3. Add the missing dependencies noted at step 5 to `Dockerfile-AL9-MNXB11`. 
        Please add only runtime libraries, binaries and headers, but no source code!
   7.3. Rebuild the container with the new software and scripts. The script is suck 
   ```bash
   # NOTE: no -dev in this one!!
   docker build -t "mnxb11:al9-dev.myversion" -f Dockerfile-AL9-MNXB11
   ```

## 8. (Optional) Upload the container to dockerhub

  8.1. Tag the container with an appropriate tag:
  ```bash
  docker tag mnxb11:al9-dev.myversion yourdockerusername/mnxb11:al9-dev.myversion
  docker push yourdockerusername/mnxb11:al9-dev.myversion
  ```

## 9. Fork the repo and add your fork, then submit a pull request

Alternatively you can send me the files, but I would really prefer you use git.

This is standard git/github flow so I will just write the commands as a reminder.

  9.1. Go on github and fork the repo.
  9.2. Change my repo to be the upstream
  ```bash
  git remote rename origin upstream
  ```
  9.3. Add your fork
  ```bash
  git remote add origin <yourforkurl>
  ```
  9.4. Commit and add changes. **DO NOT ADD the binaries in `apps`!!!!**
  ```bash
   git add Dockerfile-AL9-MNXB11* scripts/*
   git commit -m 'Added software mysoftware'
  ```
  9.5. Push to origin
  ```bash
  git push origin main
  ```
  9.6. Submit a pull request on github

# Building software in an existing container

TODO



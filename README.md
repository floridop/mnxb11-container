# mnxb11-container
Container dockerfiles for the MNXB11 course

If you're a student attending the course, you do not need these files. These are for the teachers
to prepare the environment.

Instead dowload the prebuilt images directly from dockerhub:

`TODO URL HERE`

# Dockerfiles description

`Dockerfile-AL9-MNXB11`

The basic minimal Dockerfile to build the course container. It does not contain sources to build software.

Only binaries and headers should be added to this container.

`Dockerfile-AL9-MNXB11-dev`

The Docker container used to build some of the software. It will download the sources needed and build the
software at container creation time.

You should download this if you're a teacher or a student that wants to build additional software for the container.

It takes more time and it will generate a larger container image.

# How to build

NOTE: you do not need to build the container if you're attending the course. This is mainly for teachers.

The container follows the standard Docker build procedure described at

<https://docs.docker.com/engine/reference/commandline/build/>

## Requirements

  1. Install Docker Desktop or Docker Engine from <https://docs.docker.com/get-docker/>

If you're totally new to Docker I recommend to read <https://docs.docker.com/get-started/>

## Commands

  1. Get this repo from github:
     ```git clone https://github.com/floridop/mnxb11-container.git```
  2. Cd into the repo
     ```cd mnxb11-container```
  3. Run docker build on the selected container, i.e.
     ```docker build -t "mnxb11al9:version" -f Dockerfile-AL9-MNXB11 .```
  4. Wait until the build completes
  5. You can now list the build container with
  ```docker image ls```
  6. You can start the container with
  ```docker run -it mnxb11al9:version```



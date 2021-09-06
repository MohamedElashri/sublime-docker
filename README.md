[![Docker Image CI](https://github.com/MohamedElashri/sublime-docker/actions/workflows/docker-run.yml/badge.svg)](https://github.com/MohamedElashri/sublime-docker/actions/workflows/docker-run.yml)

# sublime-docker
This docker image is to run sublime 3 inside a docker container

## Installation

I would recommend using the `docker_setup.sh` script inside `scripts` folder to install and run the container and changing the env variables to your needs. 

To use the script you have first to give it execusion permission. You should run the following

First clone this repository

```
git clone https://github.com/MohamedElashri/sublime-docker
```

Then give execusion permission to the setup script
```
chmod +x scripts/docker_setup.sh
```

Run the script 

```
./docker_setup.sh
```

You might want to change the default variables inside the setup script 

## Variables 



| Variable | description | 
| -------- | -------- | 
| `HOST_SUBLIME_DIR`     | The location of where default workspace mounted in `Host` machine    |
`HOST_SUBLIME_CONFIG_DIR` | The location Where to persist Sublime settings and installed packages|
`USER_NAME` | Username of the container |
`IMAGE_NAME` | Image name, default is `melashri/sublime` change it only if you have build it yourself or using another image available on Docker hub. |
``

## Build image 

In case you want to build image, specially if you want to use another sublime build version you can edit the `Dockerfile` and change `ARG SUBLIME_BUILD` to the suitable build number. Then you need to build the image 

```
docker build . --file Dockerfile --tag sublime-docker:<tag>
```

You will need to change `<tag>`, the default if you remove will be `latest` tag. 

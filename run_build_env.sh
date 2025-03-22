#!/usr/bin/env bash

ENVIRONMENT_DIR=yocto_environment

if [ ! -d $ENVIRONMENT_DIR ]; then
    mkdir $ENVIRONMENT_DIR
fi

docker run -it --rm --name yocto-build --user $(id -u):$(id -g)  -v $(pwd):/yocto yocto-build-env bash -c "cp build.sh $ENVIRONMENT_DIR; cp meta-custom-layer $ENVIRONMENT_DIR -r;cp start_qemu.sh $ENVIRONMENT_DIR; cd $ENVIRONMENT_DIR;chmod +x build.sh; exec bash" 


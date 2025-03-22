#!/bin/bash

POKY_VERSION="kirkstone"
BUILD_DIR=yocto_build_result
IMAGE_NAME=custom-image-minimal
MACHINE=raspberrypi3-64

if [ ! -z $1 ] && [ "$1" = "clean" ]; then
    rm -rf poky
    rm -rf meta-raspberrypi
    rm -rf meta-openembedded
    rm -rf $BUILD_DIR
    exit 0
fi

if [ ! -d poky ]; then
    git clone git://git.yoctoproject.org/poky.git -b $POKY_VERSION
else
    cd poky
    git checkout $POKY_VERSION
    git pull
    cd ..
fi

if [ ! -d meta-raspberrypi ]; then
    git clone git://git.yoctoproject.org/meta-raspberrypi -b $POKY_VERSION
else
    cd meta-raspberrypi
    git checkout $POKY_VERSION
    git pull
    cd ..
fi

if [ ! -d meta-openembedded ]; then
    git clone git://git.openembedded.org/meta-openembedded -b $POKY_VERSION
else
    cd meta-openembedded
    git checkout $POKY_VERSION
    git pull
    cd ..
fi

if [ ! -d $BUILD_DIR ]; then
    mkdir $BUILD_DIR
fi

source poky/oe-init-build-env $BUILD_DIR
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-raspberrypi/
bitbake-layers add-layer ../meta-custom-layer

sed -i -e "s/MACHINE ??= \"qemux86-64\"/MACHINE ??= \"$MACHINE\"/g" conf/local.conf

if [ ! -z $1 ] && [ "$1" = "toolchain" ]; then

    bitbake $IMAGE_NAME -c populate_sdk
    exit 0
fi

bitbake $IMAGE_NAME

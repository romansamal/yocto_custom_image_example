# Package summary
SUMMARY = "Hello World"
# License, for example MIT
LICENSE = "MIT"
# License checksum file is always required
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# hello-world.c from local file
SRC_URI = "file://server.cpp\
           file://client.cpp\
           file://CMakeLists.txt"

S = "${WORKDIR}"

DEPENDS += "pkgconfig-native"
DEPENDS += "cppzmq"

inherit cmake

#EXTRA_OECMAKE = ""

# Set LDFLAGS options provided by the build system
#TARGET_CC_ARCH += "${LDFLAGS}"


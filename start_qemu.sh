#!/bin/bash
qemu-system-aarch64 -M raspi3b -m 1024 -sd build/sdimage-raspberrypi-202502210840-mmcblk0.direct -dtb build/tmp/deploy/images/raspberrypi3-64/bcm2710-rpi-3-b.dtb -kernel build/tmp/deploy/images/raspberrypi3-64/Image -append "console=ttyAMA0,115200 root=/dev/mmcblk0p2 rootdelay=1" -nographic

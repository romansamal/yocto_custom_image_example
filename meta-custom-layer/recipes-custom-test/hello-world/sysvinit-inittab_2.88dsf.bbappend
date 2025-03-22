do_install:append(){
    echo "1:12345:respawn:/sbin/getty ttyAMA0 115200" >> ${D}${sysconfdir}/inittab
}

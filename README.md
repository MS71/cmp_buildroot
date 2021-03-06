# (Car Media Player) CMP Buildroot #

This is an buildroot external (overlay) for building a CMP OS.

# OS Feature
- Buildroot linux system
- Systemd
- WiFi Client & AP
- Samba File Share
- Bluetooth/BlueZ5
- Bluetooth A2DP Audio Streaming to Car Headunit
- Bluetooth AVRCP Control
- Qt5 QML Support
- FBTFT Touch Display
- PulseAudio
- GStreamer
- Welle.IO

# Target System
- Banana PI M2 ZERO (https://bananapi.gitbooks.io/bpi-m2-/content/en/bpi-m2-zero-hardware.html)
![alt text](http://www.banana-pi.org/images/bpi-images/ZERO/zero1.jpg)
- Watterott RPI Display (https://www.watterott.com/de/RPi-Display-B-Plus)
![alt text](https://www.watterott.com/media/images/popup/20110952_1.jpg)
- 5mm Header (https://www.reichelt.de/2x10pol-buchsenleiste-gerade-rm-2-54-bl-2x10g-2-54-p6074.html)
![alt text](https://cdn-reichelt.de/bilder/web/artikel_ws/C140/BL_2X10G_2_54.jpg)

# System
![alt text](images/System.png)

# My Car
![alt text](images/mycar.jpg)

# 3D Case
![alt text](images/bpiz_01.png)

# Tree
```
cmp_buildroot/
├── external.desc
├── external.mk
├── LICENSE
├── README.md
├── Config.in
│
├── configs
│   └── bananapi_m2_zero_cmp_defconfig
│
├── board
│   └── bananapi
│       └── bananapi-m2-zero
│           ├── boot.cmd
│           ├── bpiz-fbtft.dts
│           ├── genimage.cfg
│           ├── genimage-initrd.cfg
│           ├── linux-bananapi-m2-zero.cfg
│           ├── sun8i-bpi-m2-zero-fbtft.dts
│           └── uboot-add-bananapi-m2-zero.patch
│
└── rootfs_overlay
    └── etc
        ├── bluetooth
        │   ├── audio.conf
        │   └── main.conf
        ├── dbus-1
        │   └── system.conf
        ├── fstab
        ├── init.d
        │   ├── S41bluetooth
        │   └── S99startapp
        ├── network
        │   └── interfaces
        ├── samba
        │   └── smb.conf
        └── ssh
            └── sshd_config
```

# Building
- mkdir cmp
- cd cmp
- git clone https://github.com/buildroot/buildroot.git
- cd buildroot
- git checkout 2019.05
- cd ..
- git clone https://github.com/MS71/cmp_buildroot.git
- cd buildroot
- export BR2_EXTERNAL=$PWD/../cmp_buildroot
- make bananapi_m2_zero_cmp_defconfig
- time make<br>
    ...<br>
    INFO: hdimage(sdcard.img): adding partition 'u-boot' from 'u-boot-sunxi-with-spl.bin' ...<br>
    INFO: hdimage(sdcard.img): adding partition 'boot' (in MBR) from 'boot.vfat' ...<br>
    INFO: hdimage(sdcard.img): adding partition 'rootfs' (in MBR) from 'rootfs.ext4' ...<br>
    INFO: hdimage(sdcard.img): writing MBR<br>
    real	119m20,462s<br>
    user	386m0,202s<br>
    sys	46m18,693s<br>
- make ffmpeg4
- make

# Target Installation



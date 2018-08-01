# (Car Media Player) CMP Buildroot #

This is an buildroot external (overlay) for building a CMP OS.

# OS Feature
- Buildroot linux system
- WiFi Client & AP
- Samba File Share
- Bluetooth
- Bluetooth A2DP Audio Streaming to Car Headunit
- Qt5 QML Support
- FBTFT Touch Display

# Target System
- Banana PI M2 ZERO (http://www.banana-pi.org/bpi-zero.html)
![alt text](http://www.banana-pi.org/images/bpi-images/ZERO/zero1.jpg)
- Watterott RPI Display (https://www.watterott.com/de/RPi-Display-B-Plus)
![alt text](https://www.watterott.com/media/images/popup/20110952_1.jpg)

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
- git clone https://github.com/MS71/cmp_buildroot.git
- cd buildroot
- export BR2_EXTERNAL=$PWD/../cmp_buildroot
- make bananapi_m2_zero_cmp_defconfig
- make
- ... some hours ...

# Target Installation



# (Car Media Player) CMP Buildroot #

This is an buildroot external (overlay) for building a CMP OS.

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


# Tree
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


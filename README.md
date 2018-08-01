# (Car Media Player) CMP Buildroot #

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




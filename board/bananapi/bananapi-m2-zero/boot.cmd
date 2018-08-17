
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait consoleblank=0 quiet 

mmc dev 0
fatload mmc 0 $kernel_addr_r zImage
fatload mmc 0 $fdt_addr_r bpiz-fbtft.dtb

bootz $kernel_addr_r - $fdt_addr_r

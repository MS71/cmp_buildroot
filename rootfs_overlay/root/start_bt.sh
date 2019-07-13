#!/bin/bash

# enable Bluetooth AP6212 ...
devmem2 0x1f00060 b 1
echo 204 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio204/direction
echo 0 > /sys/class/gpio/gpio204/value
echo 1 > /sys/class/gpio/gpio204/value
sleep 0.1
# generate BT MAC
export BTADDR_FILE=/data/bt.addr
if [ -f $BTADDR_FILE ]; then
 echo ""
else
 tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/' > $BTADDR_FILE
fi   
/usr/bin/hciattach /dev/ttyS1 bcm43xx 1500000 flow bdaddr `cat $BTADDR_FILE` 
hciconfig hci0 up
hciconfig hci0 sspmode 0 


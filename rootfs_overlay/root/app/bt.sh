#!/bin/sh
# enable BT6212 ...
devmem2 0x1f00060 b 1
echo 204 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio204/direction
echo 0 > /sys/class/gpio/gpio204/value
echo 1 > /sys/class/gpio/gpio204/value
sleep 0.1
/usr/bin/hciattach /dev/ttyS1 bcm43xx 1500000 flow bdaddr 43:29:B1:55:01:01
hciconfig hci0 up
bluealsa&
sleep 0.1
echo -e 'power on\npair B8:D5:0B:C4:80:C7\nconnect B8:D5:0B:C4:80:C7\t \nquit' | bluetoothctl

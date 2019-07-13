#!/bin/bash
echo "running /root/start.sh ..."
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# enable BL
echo 1 > /sys/class/backlight/fb_ili9341/bl_power
systemctl start psplash-start

# start watchdog ...
watchdog -T 5 /dev/watchdog0

# configure network ...
psplash-write "MSG Init Network ..."
ifconfig eth0 192.168.1.100
psplash-write "PROGRESS 10"

# start gps
#if [ -e /dev/ttyUSB0 ]; then
# systemctl start gpsd
#fi

# check for ssh key ...
if [ ! -f /etc/ssh/ssh_host_dsa_key ]; then
 psplash-write "MSG Init SSH ..."
 echo "rebuild /etc/ssh/ssh_host_dsa_key ..."
 mount /dev/root -o remount,rw
 /etc/init.d/S50sshd restart
 sync
 mount /dev/root -o remount,ro 
fi
psplash-write "PROGRESS 20"

# check for /dev/mmcblk0p3
if [ ! -e /dev/mmcblk0p3 ]; then
 psplash-write "MSG Init /data"
 echo -e "n\np\n3\n\n\np\nw" | fdisk /dev/mmcblk0
 sync 
 mkfs.ext4 /dev/mmcblk0p3 -L data -j -q
 sync
 psplash-write "MSG Rebooting"
 reboot
fi
psplash-write "PROGRESS 30"

# mount /data
if [ ! -e /dev/mmcblk0p3 ]; then
 echo "error: can't find /dev/mmcblk0p3"
 exit
else 
 psplash-write "MSG Mount /data"
 mkdir -p /data
 mount /dev/mmcblk0p3 /data
fi
psplash-write "PROGRESS 40"

# increment /data/boot.cnt
BOOTCNTFN=/data/boot.cnt
if [ ! -f $BOOTCNTFN ]; then
 echo 1 > $BOOTCNTFN
 BOOTCNT=1
else
 N=`cut -d ',' -f2 $BOOTCNTFN`
 N=`expr $N + 1`
 echo $N > $BOOTCNTFN
 BOOTCNT=$N
fi

# create log directory
mkdir -p /data/log

# enable Bluetooth AP6212 ...
#psplash-write "MSG Init Bluetooth ..."
#devmem2 0x1f00060 b 1
#echo 204 > /sys/class/gpio/export
#echo out > /sys/class/gpio/gpio204/direction
#echo 0 > /sys/class/gpio/gpio204/value
#echo 1 > /sys/class/gpio/gpio204/value
#sleep 0.1
# generate BT MAC
#export BTADDR_FILE=/data/bt.addr
#if [ -f $BTADDR_FILE ]; then
# echo ""
#else
# tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/' > $BTADDR_FILE
#fi   
#/usr/bin/hciattach /dev/ttyS1 bcm43xx 1500000 flow bdaddr `cat $BTADDR_FILE` 
#hciconfig hci0 up
#hciconfig hci0 sspmode 0 
/root/start_bt.sh&
psplash-write "PROGRESS 50"

# Init TSLib
export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_TSDEVICE=/dev/input/event0 
export TSLIB_CALIBFILE=/data/tslib.calib

if [ ! -f $TSLIB_CALIBFILE ]; then
 ts_calibrate
 sync
 #ts_test
fi
psplash-write "PROGRESS 60"

# starting application ...
if [ -f /data/app/start.sh ]; then
 psplash-write "PROGRESS 90"
 psplash-write "MSG starting app ..."
 systemctl stop psplash-start
 chmod +x /data/app/start.sh
 dbus-run-session /data/app/start.sh &> /tmp/app_start.log &
else
 psplash-write "PROGRESS 90"
 psplash-write "MSG starting welle-io ..."
 systemctl stop psplash-start
 dbus-run-session /root/welle.sh &> /tmp/welle.log &
fi

# EOF
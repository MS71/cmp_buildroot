#!/bin/sh
# start watchdog ...
watchdog -T 5 /dev/watchdog0

# configure network ...
ifconfig eth0 192.168.1.100

echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 816000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

kill welle-io

if [ -f /etc/ssh/ssh_host_dsa_key ]; then
 echo ""
else
 mount /dev/root -o remount,rw
 /etc/init.d/S50sshd restart
 sync
 mount /dev/root -o remount,ro 
fi

# create /tmp/app if not exists ...
if [ -d /tmp/app ]; then
 echo ""
else
 mkdir /tmp/app
fi


if [ -e /dev/sda1 ]; then
 echo ""
else
 sleep 1
fi

# mount /dev/sda1 or /dev/mmcblk0p1
if [ -e /dev/sda1 ]; then
 mount /dev/sda1 /tmp/app
else
 mount /dev/mmcblk0p1 /tmp/app
fi
sleep 1
sync
mount /tmp/app -o remount,rw
sync

# enable Bluetooth AP6212 ...
devmem2 0x1f00060 b 1
echo 204 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio204/direction
echo 0 > /sys/class/gpio/gpio204/value
echo 1 > /sys/class/gpio/gpio204/value
sleep 0.1
# generate BT MAC
export BTADDR_FILE=/tmp/app/bt.addr                                      
if [ -f $BTADDR_FILE ]; then                                               
 echo ""                                                                       
else                                                                           
 tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/' > $BTADDR_FILE                                                            
fi   
/usr/bin/hciattach /dev/ttyS1 bcm43xx 1500000 flow bdaddr `cat $BTADDR_FILE` 
hciconfig hci0 up
hciconfig hci0 sspmode 0 

if [ -f /tmp/app/app.img ]; then
  losetup /dev/loop0 /tmp/app/app.img
  mkdir /tmp/app.img
  mount /dev/loop0 /tmp/app.img
  dbus-run-session /tmp/app.img/session.sh &> /tmp/session.log &
else
  dbus-run-session /root/app/welle.sh &> /tmp/welle.log &
fi


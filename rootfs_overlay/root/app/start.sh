#!/bin/bash
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

# create /tmp/mmcvfat if not exists ...
if [ -d /tmp/mmcvfat ]; then
 echo ""
else
 mkdir /tmp/mmcvfat
fi

mount /dev/mmcblk0p1 /tmp/mmcvfat
sync
mount /tmp/mmcvfat -o remount,rw
sync

# check for update from sda1 ...
if [ -e /tmp/sda1 ]; then
  umount /tmp/sda1
else
  mkdir /tmp/sda1
fi
#
if [ -e /dev/sda1 ]; then
  mount /dev/sda1 /tmp/sda1
fi
#
if [ -e /tmp/sda1/app.zip ]; then
  NEWMD5SUM=($(md5sum /tmp/sda1/app.zip))
  OLDMD5SUM=
  if [ -f /tmp/mmcvfat/app.md5 ]; then
    OLDMD5SUM=$(cat /tmp/mmcvfat/app.md5)
  fi
  cd /tmp/mmcvfat
  if [ "0x$OLDMD5SUM" != "0x$NEWMD5SUM" ] ; then
    echo "updating ..."
    cd /tmp/mmcvfat
    unzip -oq /tmp/sda1/app.zip
    echo $NEWMD5SUM > /tmp/mmcvfat/app.md5
    sync
    echo "updating ... done"
    exit
  fi
  tar cvf /tmp/sda1/app_backup.tar app
  sync
fi

# enable Bluetooth AP6212 ...
devmem2 0x1f00060 b 1
echo 204 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio204/direction
echo 0 > /sys/class/gpio/gpio204/value
echo 1 > /sys/class/gpio/gpio204/value
sleep 0.1
# generate BT MAC
export BTADDR_FILE=/tmp/mmcvfat/bt.addr                                      
if [ -f $BTADDR_FILE ]; then                                               
 echo ""                                                                       
else                                                                           
 tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/' > $BTADDR_FILE                                                            
fi   
/usr/bin/hciattach /dev/ttyS1 bcm43xx 1500000 flow bdaddr `cat $BTADDR_FILE` 
hciconfig hci0 up
hciconfig hci0 sspmode 0 

if [ -f /tmp/mmcvfat/app/start.sh ]; then
  chmod +x /tmp/mmcvfat/app/start.sh
  /tmp/mmcvfat/app/start.sh &
else
  dbus-run-session /root/app/welle.sh &> /tmp/welle.log &
fi


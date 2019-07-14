#!/bin/bash
echo "start_sda1 ..."

BOOTCNTFN=/data/boot.cnt
if [ ! -f $BOOTCNTFN ]; then
 echo "$BOOTCNTFN not found, exit"
 exit 0
fi

BOOTCNT=`cut -d ',' -f2 $BOOTCNTFN`

if [ ! -b "/dev/sda1" ]; then
  echo "/dev/sda1 not found, exit"
  exit 0
fi

mkdir -p /mnt
fsck.vfat -a /dev/sda1
mount /dev/sda1 /mnt

if [ ! -d /mnt/app_backup ]; then
  echo "/mnt/app_backup not found, exit"
  exit 0 
fi

#exit 0

if [ ! -d /var/lib/bluetooth ]; then
  if [ -f /mnt/app_backup/var_lib_bluetooth.zip ]; then
    cd /
    unzip /mnt/app_backup/var_lib_bluetooth.zip
    cd -
  fi
fi

# Restore bt.addr file if possible
if [ ! -f /data/bt.addr ]; then
  if [ -f /mnt/app_backup/bt.addr ]; then
    cp /mnt/app_backup/bt.addr /data/bt.addr
  fi
fi

# Restore tslib.calib file if possible
export TSLIB_CALIBFILE=/data/tslib.calib
if [ ! -f $TSLIB_CALIBFILE ]; then
  if [ -f /mnt/app_backup/tslib.calib ]; then
    cp /mnt/app_backup/tslib.calib $TSLIB_CALIBFILE
  fi
fi

# stop app
echo 0 > /sys/class/backlight/fb_ili9341/bl_power
/root/stop.sh
#fb-test-rect&
sleep 1

cd /data
#
mkdir -p /mnt/app_backup
zip -r /mnt/app_backup/$BOOTCNT-app.zip app bt.addr tslib.calib log
zip -r /mnt/app_backup/var_lib_bluetooth.zip /var/lib/bluetooth
rm -rf /data/log/*
cp bt.addr     /mnt/app_backup/.
cp tslib.calib /mnt/app_backup/.
cp boot.cnt    /mnt/app_backup/.
sync  

if [ -e /mnt/app.zip ]; then
  NEWMD5SUM=($(md5sum /mnt/app.zip))
  OLDMD5SUM=
  if [ -f /data/app.md5 ]; then
    OLDMD5SUM=$(cat /data/app.md5)
  fi
  cd /data
  if [ "0x$OLDMD5SUM" != "0x$NEWMD5SUM" ] ; then
    unzip -oq /mnt/app.zip
    echo $NEWMD5SUM > /data/app.md5
    sync
  fi
  umount /mnt
fi

reboot

#killall -q fb-test-rect

exit 0
#!/bin/sh
# start watchdog ...
watchdog -T 5 /dev/watchdog0

# configure network ...
ifconfig eth0 192.168.1.100

echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 648000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

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

# enable BT6212 ...
devmem2 0x1f00060 b 1
echo 204 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio204/direction
echo 0 > /sys/class/gpio/gpio204/value
echo 1 > /sys/class/gpio/gpio204/value
sleep 0.1
/usr/bin/hciattach /dev/ttyS1 bcm43xx 1500000 flow bdaddr 43:29:B1:55:01:01
hciconfig hci0 sspmode 0
hciconfig hci0 up
bt-agent -c NoInputNoOutput -p /etc/bluetooth/pins.cfg -d
echo -e 'power on\nagent on\ndiscoverable on\npairable on\nquit' | bluetoothctl

# enable rtlsdr bias tee
rtl_biast -d 0 -b 1
rtl_biast -d 1 -b 1

#gst-launch-1.0 audiotestsrc ! autoaudiosink

cd /root/app
export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/qt/plugins/platforms
export QT_QPA_PLATFORM=linuxfb:fb=/dev/fb0:size=240x320
#export QT_QPA_FB_HIDECURSOR=1
export QT_QPA_GENERIC_PLUGINS=tslib:/dev/input/event0
export QT_QPA_FB_TSLIB=1
export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_TSDEVICE=/dev/input/event0 
cd /tmp/app
echo 1 > /sys/class/backlight/fb_ili9341/bl_power
export TSLIB_CALIBFILE=/tmp/app/tslib.calib
if [ -f $TSLIB_CALIBFILE ]; then
 echo ""
else
 ts_calibrate
 sync
 ts_test
fi

# start elle-io
welle-io -plugin tslib:/dev/input/event0 --log-file /tmp/welle.log --dab-mode 1 &

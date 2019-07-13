#!/bin/sh
echo "statring welle-io ..."
cd /root

export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/qt/plugins/platforms
export QT_QPA_PLATFORM=linuxfb:fb=/dev/fb0:size=240x320
#export QT_QPA_FB_HIDECURSOR=1
export QT_QPA_GENERIC_PLUGINS=tslib:/dev/input/event0
export QT_QPA_FB_TSLIB=1
export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_TSDEVICE=/dev/input/event0 
cd /tmp/mmcvfat
echo 1 > /sys/class/backlight/fb_ili9341/bl_power
export TSLIB_CALIBFILE=/data/tslib.calib

echo "export DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" > /tmp/DBUS_SESSION_BUS_ADDRESS.sh
chmod +x /tmp/DBUS_SESSION_BUS_ADDRESS.sh

bt-agent -c NoInputNoOutput -p /etc/bluetooth/pins.cfg 2> /tmp/bt-agent.log & 
echo -e 'power on\nagent on\ndiscoverable on\npairable on\nquit' | bluetoothctl

# enable rtlsdr bias tee           
rtl_biast -d 0 -b 1        
rtl_biast -d 1 -b 1   

echo "start welle-io ..."
mpris-proxy &
welle-io -plugin tslib:/dev/input/event0 > /tmp/welle_io.txt

echo "... done"

#!/bin/sh
killall -q gst-launch-1.0
killall -q qml_scanner
gst-launch-1.0 audiotestsrc volume=0.1 ! autoaudiosink&

export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/qt/plugins/platforms
export QT_QPA_PLATFORM=linuxfb:fb=/dev/fb0:size=240x320
#export QT_QPA_FB_HIDECURSOR=1
export QT_QPA_GENERIC_PLUGINS=tslib:/dev/input/event0
export QT_QPA_FB_TSLIB=1
export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_TSDEVICE=/dev/input/event0 
export TSLIB_CALIBFILE=/data/tslib.calib

/root/stop.sh
/root/qml_scanner -plugin tslib:/dev/input/event0&




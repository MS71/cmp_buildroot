#!/bin/bash
killall -q gpxlogger
if [ -f /data/app/stop.sh ]; then
 chmod +x /data/app/stop.sh
 /data/app/stop.sh
else
 killall -q welle-io
fi

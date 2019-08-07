#!/bin/bash
killall -q gpxlogger
systemctl stop gpsd
systemctl start gpsd
BOOTCNTFN=/data/boot.cnt 
while [ ! -f $BOOTCNTFN ] ; 
do
  sleep 1
done
if [ -f $BOOTCNTFN ]; then
 BOOTCNT=`cut -d ',' -f2 $BOOTCNTFN`
 mkdir -p /data/log
 while true; do
  gpxlogger -e sockets -r -m 1 -f /data/log/${BOOTCNT}_`date +"%Y%m%d_%H%M%S"`.gpx
  sleep 1
 done
fi

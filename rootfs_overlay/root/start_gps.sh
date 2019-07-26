#!/bin/bash
killall -q gpxlogger
systemctl stop gpsd
systemctl start gpsd
if [ -f /data/boot.cnt ]; then
 BOOTCNTFN=/data/boot.cnt
 BOOTCNT=`cut -d ',' -f2 $BOOTCNTFN`
 #if [ ! -f /data/log/$BOOTCNT.gpx ]; then
  mkdir -p /data/log
  #sleep 10
  while true; do
   gpxlogger -e sockets -r -m 1 -f /data/log/${BOOTCNT}_`date +"%Y%m%d_%H%M%S"`.gpx
   sleep 1
  done
 #fi
fi

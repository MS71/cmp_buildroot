#!/bin/bash
if [ -f /tmp/gps.lock ]; then
 exit
fi
touch /tmp/gps.lock
killall start_gps2.sh
/root/start_gps2.sh &> /tmp/gps.log &

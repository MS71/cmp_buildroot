#!/bin/sh
BOOTCNTFN=/data/boot.cnt
if [ -f $BOOTCNTFN ]; then
 BOOTCNT=`cut -d ',' -f2 $BOOTCNTFN`
 mkdir -p /data/log
 hcidump -w /data/log/${BOOTCNT}_hci.cap
fi


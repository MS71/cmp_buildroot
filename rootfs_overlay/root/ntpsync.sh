#!/bin/sh
ip route add default via 192.168.1.1 dev eth0
ntpdate -u ptbtime1.ptb.de
hwclock -f /dev/rtc1 -w
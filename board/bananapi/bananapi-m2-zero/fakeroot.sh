#!/bin/sh
echo "CMP fakeroot script ($1)"
###
echo "add user root to pulse-access group ..."
sed -i "s/^pulse-access.*pulse/&,root/" $1/etc/group
###
echo "modify pulseaudio system.pa configuration ..."
if ! grep -q "load-module module-switch-on-connect" "$1/etc/pulse/system.pa"; then
  echo "load-module module-switch-on-connect" >> $1/etc/pulse/system.pa
fi
if ! grep -q "load-module module-bluez5-discover" "$1/etc/pulse/system.pa"; then
  echo "load-module module-bluez5-discover" >> $1/etc/pulse/system.pa
fi
if ! grep -q "load-module module-bluez5-device" "$1/etc/pulse/system.pa"; then
  echo "load-module module-bluez5-device" >> $1/etc/pulse/system.pa
fi
if ! grep -q "load-module module-hal-detect" "$1/etc/pulse/system.pa"; then
  echo "load-module module-hal-detect" >> $1/etc/pulse/system.pa
fi
###
echo "CMP fakeroot script (${BASE_DIR}) ... done"


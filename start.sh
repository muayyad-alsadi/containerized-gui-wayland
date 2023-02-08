#! /bin/bash

dbus-daemon --session --nofork --nopidfile --nosyslog --print-address > ~/tmp/dbus.addr.txt &
export DBUS_SESSION_BUS_ADDRESS=`cat ~/tmp/dbus.addr.txt`
sleep 0.5
websockify --web /usr/share/novnc 8080 localhost:5900 &
sleep 0.5
disown -a
[ "x$1" == "xsway" ] && exec sway
[ "x$1" == "xbash" ] && exec bash
exec labwc -C /etc/xdg/labwc/


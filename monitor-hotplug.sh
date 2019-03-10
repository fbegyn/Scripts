#!/bin/bash

#Adapt this script to your needs.

DEVICES=$(find /sys/class/drm/*/status)

#inspired by /etc/acpd/lid.sh and the function it sources

displaynum=`ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##`
display=":$displaynum.0"
export DISPLAY=":$displaynum.0"

# from https://wiki.archlinux.org/index.php/Acpid#Laptop_Monitor_Power_Off
export XAUTHORITY=$(ps -C Xorg -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')

function wait_for_monitor() {
    xrandr | grep $1 | grep '\bconnected'
    while [ $? -ne 0 ]; do
            logger -t "waiting for 100ms"
            sleep 0.1
            xrandr | grep $1 | grep '\bconnected'
    done
 }

#this while loop declare the $HDMI1 $VGA1 $LVDS1 and others if they are plugged in
while read l
do
  dir=$(dirname $l);
  status=$(cat $l);
  dev=$(echo $dir | cut -d\- -f 2-);

  if [ $(expr match  $dev "HDMI") != "0" ]
  then
#REMOVE THE -X- part from HDMI-X-n
    dev=HDMI${dev#HDMI-?-}
  else
    dev=$(echo $dev | tr -d '-')
  fi

  if [ "connected" == "$status" ]
  then
    echo $dev "connected"
    declare $dev="yes";

  fi
done <<< "$DEVICES"

if [ ! -z "$DP4" ]
then
  echo "DP1-1 plugged in"
	wait_for_monitor DP1-1
  xrandr --output DP1-1 --auto --above eDP1
  xrandr --output eDP1 --off
elif [ ! -z "$DP3" ]
then
  echo "DP1-1 plugged in"
	wait_for_monitor DP1-1
  xrandr --output DP1-1 --auto --above eDP1
  xrandr --output eDP1 --off
elif [ ! -z "$DP1" ]
then
  echo "DP1 plugged in"
	wait_for_monitor DP1
  xrandr --output DP1 --auto --primary --right-of eDP1
  xrandr --output eDP1 --off
else
  echo "No external monitors are plugged in"
  xrandr --output eDP1 --auto --primary
  xrandr --output DP1-1 --off
  xrandr --output DP1 --off
fi

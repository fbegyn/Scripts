#! /usr/bin/env bash
QUEUEFILE=$HOME/Videos/.castinput
if [[ ! -p $QUEUEFILE ]]; then
    mkfifo $QUEUEFILE
fi

case $1 in
  # Appearently castnow keeps it's own queue, so not really needed
  "queue" )
    notify-send "Adding video to catt YT queue" "Adding $2 to the video queue"
    catt add $2
    ;;
  "single" )
    notify-send "New cast" "casting to device"
    catt cast $2
    ;;
esac

exit 0

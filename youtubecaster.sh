#!/bin/bash
QUEUEFILE=$HOME/Videos/.castinput
if [[ ! -p $QUEUEFILE ]]; then
    mkfifo $QUEUEFILE
fi

case $1 in
  # Appearently castnow keeps it's own queue, so not really needed
  "queue" )
    if pgrep -f youtubecaster.sh > /dev/null
    then
      notify-send "Adding video to mpv queue" "Adding $2 to the video queue"
      printf "%s\n" "loadfile \"$2\" append-play" > $QUEUEFILE
    else
      notify-send "New cast" "No cast is busy, opening new queue"
      printf "%s\n" "loadfile \"$2\" append-play" > $QUEUEFILE
      /home/francis/Scripts/youtubecast.sh "$QUEUEFILE"
    fi
    ;;
  "window" )
    notify-send "New cast" "casting to device"
    /home/francis/Scripts/youtubecast.sh "$2"
    ;;
esac

exit 0

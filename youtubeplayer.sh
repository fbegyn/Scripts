#! /usr/bin/env bash
QUEUEFILE=$HOME/Videos/.mpvinput
if [[ ! -p $QUEUEFILE ]]; then
    mkfifo $QUEUEFILE
fi

case $1 in
  "queue" )
    if pgrep -f yt-player > /dev/null
    then
      notify-send "Adding video to mpv queue" "Adding $2 to the video queue"
      printf "%s\n" "loadfile \"$2\" append-play" > $QUEUEFILE
    else
      notify-send "New MPV player" "No player is open, starting a new player"
      mpv --no-terminal --x11-name='yt-player' --input-file=$QUEUEFILE --player-operation-mode=pseudo-gui "$2" &
    fi
    ;;
  "window" )
    notify-send "New MPV player" "Opening a new player window"
    mpv --no-terminal --x11-name='video-player' --input-file=$QUEUEFILE --player-operation-mode=pseudo-gui "$2" &
    ;;
esac

exit 0

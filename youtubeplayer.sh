#! /usr/bin/env bash

case $1 in
    # queue means opening up a video player and adding videos to a fifo queue
    "queue" )
    QUEUEFILE=$HOME/Videos/.mpvinput
    # check if there already it a yt-player proces running
    if pgrep -f yt-player > /dev/null
    then
		# if so, add the new url to the fifo queue
		notify-send "Adding video to mpv queue" "Adding $2 to the video queue"
		resp=$(
		  echo "{\"command\":[\"loadfile\",\"$2\",\"append-play\"]}" \
			  | socat - $QUEUEFILE \
			  | jq -r '.error, .data.playlist_entry_id'
		)
		notify-send "Video added to playlist, status" "$resp"
    else
        notify-send "New MPV player" "No player is open, starting a new player"
        mpv --no-terminal \
			--x11-name='yt-player' \
			--input-ipc-server=$QUEUEFILE \
			--player-operation-mode=pseudo-gui "$2"

	    rm $QUEUEFILE
    fi
    ;;
    "window" )
    notify-send "New MPV player" "Opening a new player window"
    mpv --no-terminal \
		--x11-name='video-player' \
		--player-operation-mode=pseudo-gui "$2" &
    ;;
esac

exit 0

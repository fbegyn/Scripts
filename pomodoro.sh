#!/bin/bash

case $1 in
  "start")
    i3-gnome-pomodoro start
    sudo /home/francis/Scripts/focus study
    ;;
  "stop")
    i3-gnome-pomodoro stop
    sudo /home/francis/Scripts/focus
    ;;
  "pause")
    i3-gnome-pomodoro pause
    sudo /home/francis/Scripts/focus
    ;;
  "resume")
    i3-gnome-pomodoro resume
    sudo /home/francis/Scripts/focus study
    ;;
esac

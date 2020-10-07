#! /usr/bin/env bash
case "$2" in
  CONNECTED)
    SSID=$(wpa_cli -i wlp58s0 list_networks | rg CURRENT | cut -f 2)
    notify-send "WPA supplicant: connection established" "Connected to network: $SSID" ;
    ;;
  DISCONNECTED)
    notify-send "WPA supplicant: connection lost";
    ;;
esac

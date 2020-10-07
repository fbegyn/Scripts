#! /usr/bin/env bash
SSID=$(wpa_cli -iwlp58s0 list_networks | wofi --dmenu | cut -f 1)
exec wpa_cli -iwlp58s0 select_network $SSID

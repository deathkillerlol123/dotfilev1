#!/usr/bin/env bash
CHOICE=$(printf "Start uxplay\nStop uxplay" | rofi -dmenu -p "UxPlay")
case "$CHOICE" in
    "Start uxplay")
        pgrep -x uxplay >/dev/null || uxplay -p &
        ;;
    "Stop uxplay")
        pkill uxplay
        ;;
esac

#!/usr/bin/env bash

battery="/sys/class/power_supply/BAT0"

percentage=$(cat "$battery/capacity")
state=$(cat "$battery/status")

{
    echo "🔋 Battery: $percentage% — $state"
    rofi -show drun
} | rofi -dmenu

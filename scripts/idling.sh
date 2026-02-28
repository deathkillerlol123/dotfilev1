#!/bin/bash

IDLE_TIME=300   # 5 minutes
TARGET_WS=9
LAST_ACTIVITY=$(date +%s)

# Function to update last activity on input
monitor_input() {
    libinput debug-events --device /dev/input/event* | while read -r line; do
        LAST_ACTIVITY=$(date +%s)
    done
}

# Run input monitor in background
monitor_input &

while true; do
    NOW=$(date +%s)
    ELAPSED=$((NOW - LAST_ACTIVITY))
    if [ "$ELAPSED" -ge "$IDLE_TIME" ]; then
        hyprctl dispatch workspace $TARGET_WS
    fi
    sleep 1
done



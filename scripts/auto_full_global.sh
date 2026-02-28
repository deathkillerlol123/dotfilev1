#!/bin/bash

# Track whether fullscreen mode is active
fullscreen_active=0

hyprctl events -j | while read -r line; do
  # Check if the focused window changed
  if echo "$line" | grep -q '"type":"focus"'; then
    wid=$(echo "$line" | jq -r '.window')

    # Check if any window is currently fullscreen
    if hyprctl activewindow -j | jq -e '.fullscreen == 1' >/dev/null; then
      fullscreen_active=1
    else
      fullscreen_active=0
    fi

    # If fullscreen mode is active, make the newly focused window fullscreen
    if [ $fullscreen_active -eq 1 ]; then
      hyprctl dispatch fullscreen $wid 1
    fi
  fi
done

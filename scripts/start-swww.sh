#!/bin/bash
# Wait for Wayland session
while [ -z "$WAYLAND_DISPLAY" ]; do
  sleep 0.5
done

swww-daemon &
sleep 1 # small delay for initialization

# Restore last wallpaper if it exists
LAST_WALL="$HOME/dotfiles/scripts/colorschem/last_wall.txt"
if [ -f "$LAST_WALL" ]; then
  FILE=$(cat "$LAST_WALL")
  if [ -f "$FILE" ]; then
    swww img "$FILE"
  fi
fi

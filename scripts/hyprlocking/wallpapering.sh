#!/bin/bash

CONF="$HOME/.config/hypr/hyprlock.conf"
LASTWALL="$HOME/.config/hypr/scripts/last_wall.txt"
PLACEHOLDER="wall_paper"

# Check if last wallpaper file exists
if [[ ! -f "$LASTWALL" ]]; then
  echo "Error: last wallpaper file not found."
  exit 1
fi

# Read the current wallpaper path, remove newline
WALL="$(tr -d '\n' <"$LASTWALL")"

# Replace only the first occurrence of path = with the current wallpaper
sed -i "0,/^    path = /{s|^    path = .*|    path = $WALL|;}" "$CONF"

hyprlock

# Restore the placeholder after unlocking
sed -i "0,/^    path = /{s|^    path = .*|    path = $PLACEHOLDER|;}" "$CONF"

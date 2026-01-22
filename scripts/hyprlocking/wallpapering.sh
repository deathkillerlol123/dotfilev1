#!/bin/bash

CONF="$HOME/.config/hypr/hyprlock.conf"
LASTWALL="$HOME/.config/hypr/scripts/last_wall.txt"
PLACEHOLDER="wall_paper"

# Read the current wallpaper path, remove newline
WALL="$(tr -d '\n' <"$LASTWALL")"

# Replace placeholder with the current wallpaper
sed -i "s|^    path = .*|    path = $WALL|" "$CONF"

# Lock the screen
hyprlock

# Restore the placeholder after unlock
sed -i "s|^    path = .*|    path = $PLACEHOLDER|" "$CONF"

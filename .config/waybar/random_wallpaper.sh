#!/usr/bin/env bash

cd ~/dotfiles/.config/waybar/

COLORS="$HOME/.cache/wal"
OUPUT="$HOME/dotfiles/.config"

LAST_WALL="$HOME/dotfiles/scripts/colorschem/last_wall.txt"

# Pick wallpaper
FILE=$(find ~/Pictures/Wallpapers/ -type f -print0 | shuf -zn1 | xargs -0 echo)
echo "$FILE"
if [ -n "$FILE" ]; then
  echo "$FILE" >"$LAST_WALL"

  swww img "$FILE" --transition-type fade --transition-step 90 --transition-duration 7 &
  wal -i "$FILE" -n
  pkill -f rofi

  cp "${COLORS}/colors-waybar.css" "${OUPUT}/waybar/colors.css"
  cp "${COLORS}/colors.css" "${OUPUT}/swaync/"
  cp "${COLORS}/colors-kitty.conf" "${OUPUT}/kitty/"
  cp "${COLORS}/colors-zed.json" "${OUPUT}/zed/themes/pywal.json"

  "$HOME/dotfiles/.config/waybar/css_rasi.sh"
  mv colors.rasi "${OUPUT}/rofi/colors.rasi"

  cd ~/dotfiles/nixos/themes/limine_wallpaper/
  rm -rf *
  cp "$FILE" "$HOME/dotfiles/nixos/themes/limine_wallpaper/"

fi

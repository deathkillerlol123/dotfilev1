#!/usr/bin/env bash

cd ~/dotfiles/nixos/dots/nixboom/.config/waybar/

COLORS="$HOME/.cache/wal"
OUPUT="$HOME/dotfiles/nixos/dots/nixboom/.config"

# Pick wallpaper
FILE=$(find ~/Pictures/Wallpapers/ -type f -print0 | shuf -zn1 | xargs -0 echo)
echo "$FILE"
if [ -n "$FILE" ]; then
  swww img "$FILE" --transition-type fade --transition-step 90 --transition-duration 7 &
  wal -i "$FILE" -n

  cp "${COLORS}/colors-waybar.css" "${OUPUT}/waybar/colors.css"
 # cp "${COLORS}/colors.css" "${OUPUT}/swaync/"
#  cp "${COLORS}/colors-kitty.conf" "${OUPUT}/kitty/"
#  cp "${COLORS}/colors-zed.json" "${OUPUT}/zed/themes/pywal.json"

  "$HOME/dotfiles/nixos/dots/nixboom/.config/waybar/css_rasi.sh"
  mv colors.rasi "${OUPUT}/rofi/colors.rasi"
  pkill -f rofi

  cd ~/dotfiles/nixos/themes/
  rm -rf *
  cp "$FILE" "$HOME/dotfiles/nixos/themes/"

fi

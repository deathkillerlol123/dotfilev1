#!/usr/bin/env bash

cd ~/dotfiles/nixos/dots/nixboom/.config/waybar/
COLORS="$HOME/.cache/wal"
FINALOUTPUT="$HOME/dotfiles/nixos/dots/nixboom/.config"
FILE=$(find ~/Pictures/Wallpapers/ -type f -print0 | shuf -zn1 | xargs -0 echo)
echo "$FILE"
if [ -n "$FILE" ]; then
  wal -i "$FILE" &&
  cp ~/.cache/wal/ghostty.conf ~/dotfiles/nixos/dots/nixboom/.config/ghostty/ghostty.conf
  cp "${COLORS}/colors-waybar.css" "${FINALOUTPUT}/waybar/colors.css"
  INPUT="colors.css"
  output_rasi="colors.rasi"
  if [[ -z "$INPUT" || -z "$output_rasi" ]]; then
    echo "Usage: $0 input_file output_file"
    exit 1
  fi  
  {
    echo "* {"
    grep '@define-color' "$INPUT" | while read -r line; do
      name=$(echo "$line" | awk '{print $2}')
      value=$(echo "$line" | awk '{print $3}' | tr -d ';')
      echo "    $name: $value;"
    done
    echo "}"
  } >"${output_rasi}"
  mv "${FINALOUTPUT}/waybar/colors.rasi" "${FINALOUTPUT}/rofi/colors.rasi"
  pkill -x rofi -u "$USER" || true
  cd ~/dotfiles/nixos/bootloader/
  rm -rf * &&
  cp "$FILE" "$HOME/dotfiles/nixos/bootloader/"
fi

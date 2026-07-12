#!/usr/bin/env bash

cd ~/dotfiles/nixos/dots/nixboom/.config/waybar/
COLORS="$HOME/.cache/wal"
OUPUT="$HOME/dotfiles/nixos/dots/nixboom/.config"
FILE=$(find ~/Pictures/Wallpapers/ -type f -print0 | shuf -zn1 | xargs -0 echo)
echo "$FILE"
if [ -n "$FILE" ]; then
  wal -i "$FILE" &&
  cp ~/.cache/wal/ghostty.conf ~/dotfiles/nixos/dots/nixboom/.config/ghostty/ghostty.conf
  cp "${COLORS}/colors-waybar.css" "${OUPUT}/waybar/colors.css"
  INPUT="colors.css"
  OUTPUT="colors.rasi"
  if [[ -z "$INPUT" || -z "$OUTPUT" ]]; then
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
  } >"$OUTPUT"
  mv colors.rasi "${OUPUT}/rofi/colors.rasi"
  pkill -f rofi 
  cd ~/dotfiles/nixos/bootloader/
  rm -rf * &&
  cp "$FILE" "$HOME/dotfiles/nixos/bootloader/"
fi

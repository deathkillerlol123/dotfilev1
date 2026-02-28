#!/usr/bin/env bash

cd ~/dotfiles/.config/waybar/

LAST_WALL="$HOME/dotfiles/scripts/colorschem/last_wall.txt"

# Pick wallpaper
FILE=$(find ~/Pictures/Wallpapers/ -type f -print0 | shuf -zn1 | xargs -0 echo)
echo "$FILE"
if [ -n "$FILE" ]; then
  echo "$FILE" >"$LAST_WALL"
  swww img "$FILE" --transition-type fade --transition-step 90 --transition-duration 5
  wal -i "$FILE" -n

  pkill -f rofi
  cp ~/.cache/wal/colors-waybar.css ~/dotfiles/.config/waybar/colors1.css
  cp ~/.cache/wal/colors.css ~/dotfiles/.config/mozilla/firefox/3rv9ix8a.dev-edition-default/chrome/colors1.css
  cp colors1.css ~/dotfiles/.config/wlogout/colors1.css
  cp ~/.cache/wal/colors-kitty.conf ~/dotfiles/.config/kitty/

  "$HOME/dotfiles/.config/waybar/css_rasi.sh"
  mv colors1.rasi ~/dotfiles/.config/rofi/colors1.rasi

fi

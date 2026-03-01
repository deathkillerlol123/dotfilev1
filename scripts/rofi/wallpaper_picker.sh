cd ~/dotfiles/.config/waybar/

LAST_WALL="$HOME/dotfiles/scripts/colorschem/last_wall.txt"

WALLPAPER_DIR="$HOME/Pictures"

FILE=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Select Directory" -lines 10 -width 30)
FILE="$WALLPAPER_DIR/$FILE"

cd ~/Desktop/
FILE="$(./hellpaper $FILE)"

cd ~/.config/waybar/

if [ -n "$FILE" ]; then
  echo "$FILE" >"$LAST_WALL"

  swww img "$FILE" --transition-type fade --transition-step 90 --transition-duration 7
  wal -i "$FILE" -n

  pkill -f rofi
  cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors1.css
  cp ~/.cache/wal/colors.css ~/.config/mozilla/firefox/3rv9ix8a.dev-edition-default/chrome/colors1.css
  cp colors1.css ~/.config/wlogout/colors1.css
  cp ~/.cache/wal/colors-kitty.conf ~/.config/kitty/

  "$HOME/.config/waybar/css_rasi.sh"
  mv colors1.rasi ~/.config/rofi/colors1.rasi

fi

pkill waybar
waybar &

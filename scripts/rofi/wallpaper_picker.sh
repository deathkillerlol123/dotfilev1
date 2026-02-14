cd ~/dotfiles/.config/waybar/

LAST_WALL="$HOME/dotfiles/scripts/colorschem/last_wall.txt"

WALLPAPER_DIR="$HOME/Pictures"

FILE=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Select Directory" -lines 10 -width 30)
FILE="$WALLPAPER_DIR/$FILE"
FILE="$(hellpaper $FILE)"

if [ -n "$FILE" ]; then
  echo "$FILE" >"$LAST_WALL"

  swww img "$FILE" --transition-type outer --transition-step 90
  walrus "$FILE" -t ~/.config/walrus/templates -o ~/.cache/walrus
  cp ~/.cache/walrus/colors.css ~/dotfiles/.config/waybar/colors1.css
  cp ~/dotfiles/.config/waybar/colors1.css ~/.mozilla/firefox/uv5lhq7w.dev-edition-default/chrome

  "$HOME/dotfiles/.config/waybar/col_wayhbar_conv.sh"
  "$HOME/dotfiles/.config/waybar/css_to_rasi.sh"
fi

pkill waybar
waybar &

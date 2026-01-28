cd ~/dotfiles/.config/waybar/

LAST_WALL="$HOME/dotfiles/scripts/colorschem/last_wall.txt"

# Pick wallpaper
FILE=$(find ~/Pictures/Wallpapers/ -type f -print0 | shuf -zn1 | xargs -0 echo)
echo "$FILE"
if [ -n "$FILE" ]; then
  echo "$FILE" >"$LAST_WALL"

  # Set wallpaper
  #swaybg -i "$FILE" -m fill &
  swww img "$FILE" --transition-type outer --transition-step 90

  # Generate colors with Walrus
  walrus "$FILE" -t ~/.config/walrus/templates -o ~/.cache/walrus

  cp ~/.cache/walrus/colors.css ~/dotfiles/.config/waybar/colors1.css

  cp ~/dotfiles/.config/waybar/colors1.css ~/.mozilla/firefox/uv5lhq7w.dev-edition-default/chrome

  "$HOME/dotfiles/.config/waybar/col_wayhbar_conv.sh"
  "$HOME/dotfiles/.config/waybar/css_to_rasi.sh"
fi

waybar &

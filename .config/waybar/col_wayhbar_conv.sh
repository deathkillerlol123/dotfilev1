#!/bin/bash

input="${1:-colors1.css}"
output="${2:-colors2.css}"

grep -oE -- '--[a-zA-Z0-9_-]+:[[:space:]]*#[0-9A-Fa-f]{3,6}' "$input" |
  while IFS= read -r line; do
    name=$(printf '%s' "$line" | sed -E 's/^--([a-zA-Z0-9_-]+):.*$/\1/')
    value=$(printf '%s' "$line" | sed -E 's/^--[a-zA-Z0-9_-]+:[[:space:]]*(#[0-9A-Fa-f]{3,6}).*$/\1/')
    printf '@define-color %s %s;\n' "$name" "$value"
  done >"$output"

cp colors2.css ~/dotfiles/.config/wlogout/
"$HOME/dotfiles/.config/waybar/css_to_conf.sh"
"$HOME/dotfiles/.config/waybar/mango_col.sh"

cp colors2.conf ~/dotfiles/.config/kitty/

cp mangocol1.conf ~/dotfiles/.config/mango/mangocol.conf
cd ~/dotfiles/.config/mango

value=$(awk -F'=' '/color6/ {gsub(/ /,"",$2); print $2}' mangocol.conf)
sed -i "s/^\(focuscolor *= *\).*/\1$value/" config.conf

#killall -SIGUSR2 waybar

pkill waybar
pkill rofi

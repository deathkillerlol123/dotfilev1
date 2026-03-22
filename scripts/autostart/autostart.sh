#!/usr/bin/env bash
swww-daemon &

copyq &
swaync &

brightnessctl set 10% &

"$HOME/dotfiles/scripts/niri_monitors/placement.sh" &

"$HOME/dotfiles/scripts/colorschem/start_wall.sh" &

"$HOME/dotfiles/scripts/way.sh" &


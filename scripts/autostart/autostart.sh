#!/usr/bin/env bash
kdeconnectd &
swww-daemon &
copyq &
swaync &

systemctl --user status xdg-desktop-portal-wlr
brightnessctl set 10% &

"$HOME/dotfiles/scripts/niri_monitors/placement.sh" &

"$HOME/dotfiles/scripts/colorschem/start_wall.sh" &

#"$HOME/dotfiles/scripts/way.sh" &


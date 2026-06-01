#!/usr/bin/env bash
kdeconnectd &
swww-daemon &
copyq &
swaync &

#screnshares with discords
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user start xdg-desktop-portal-wlr.service


brightnessctl set 10% &

"$HOME/dotfiles/scripts/niri_monitors/placement.sh" &

"$HOME/dotfiles/scripts/colorschem/start_wall.sh" &

#"$HOME/dotfiles/scripts/way.sh" &


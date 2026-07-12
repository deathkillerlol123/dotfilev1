#!/usr/bin/env bash

pgrep -x copyq >/dev/null || copyq &
pgrep -x awww-daemon >/dev/null || awww-daemon &

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user start xdg-desktop-portal-wlr.service

brightnessctl set 10%

"$HOME/dotfiles/nixos/scripts/placement.sh" &

img=$(find "$HOME/dotfiles/nixos/bootloader" \
    -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
    | head -n1)

[ -n "$img" ] && wal -i "$img"

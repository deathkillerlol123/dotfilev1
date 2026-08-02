#!/usr/bin/env bash

pgrep -x copyq >/dev/null || copyq &
pgrep -x awww-daemon >/dev/null || awww-daemon &

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user start xdg-desktop-portal-wlr.service

"$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/placement.sh" &

img=$(find "$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home/Wallpapers/" \
    -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
    | head -n1)

[ -n "$img" ] && wal -i "$img"

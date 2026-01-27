#!/bin/bash
set -euo pipefail

SHOW=false
for arg in "$@"; do
  case "$arg" in
  -show)
    SHOW=true
    ;;
  *) ;;
  esac
done

if $SHOW; then
  sudo pacman -Syu
  yay -Syu
else
  sudo pacman -Syu --noconfirm
  yay -Syu --noconfirm
fi

rm -rf ~/.cache/* ~/.var/app/*/cache ~/.mozilla/firefox/*/cache2/* || true

rm -rf ~/.local/share/Trash/* || true

flatpak uninstall --unused -y
flatpak repair || true

sudo find /tmp /var/tmp -mindepth 1 -delete || true
sudo rm -rf /var/cache/fontconfig/* /var/cache/man/*

sudo pacman -Sc --noconfirm
yay -Sc --noconfirm

sudo journalctl --vacuum-time=7d

mkdir ~/.cache/swww/
mkdir ~/cache/colorthief

#!/bin/bash
set -euo pipefail

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm

rm -rf ~/.cache/* ~/.var/app/*/cache ~/.mozilla/firefox/*/cache2/* ~/.local/share/Trash/* || true

flatpak uninstall --unused -y
flatpak repair || true

sudo find /tmp /var/tmp -mindepth 1 -delete || true
sudo rm -rf /var/cache/fontconfig/* /var/cache/man/*

sudo pacman -Sc --noconfirm
yay -Sc --noconfirm

sudo journalctl --vacuum-time=7d

mkdir ~/.cache/swww/
mkdir ~/.cache/colorthief

"$HOME/dotfiles/.config/waybar/random_wallpaper.sh"

nvim &
pkill nvim

"$HOME/dotfiles/.config/mango/autostart.sh"

"$HOME/dotfiles/scripts/git_updater.sh"

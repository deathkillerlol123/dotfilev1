#!/bin/bash
set -euo pipefail

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm

mv ~/.cache/zellij/ ~/ 2>/dev/null || true
rm -rf ~/.cache/*
mv ~/zellij ~/.cache/ 2>/dev/null || true

rm -rf ~/.var/app/*/cache ~/.mozilla/firefox/*/cache2/* ~/.local/share/Trash/* || true

rm -rf ~/Games/Heroic/Prefixes/oldprefixes

flatpak uninstall --unused -y
flatpak repair || true

sudo find /tmp /var/tmp -mindepth 1 -delete || true
sudo rm -rf /var/cache/fontconfig/* /var/cache/man/*

sudo pacman -Sc --noconfirm
yay -Sc --noconfirm

sudo journalctl --vacuum-time=7d

rm -rf ~/.config/discord/Cache
rm -rf ~/.config/discord/Code\ Cache
rm -rf ~/.config/whatsdesk/Cache
rm -rf ~/.config/whatsdesk/Code\ Cache
rm -rf ~/.config/heroic/cache
rm -rf ~/.config/Code/CachedExtensionVSIXs

mkdir ~/.cache/swww/
mkdir ~/.cache/colorthief

"$HOME/dotfiles/scripts/git_updater.sh" || true

nvim &
pkill nvim

"$HOME/dotfiles/.config/waybar/random_wallpaper.sh" || true

"$HOME/dotfiles/.config/mango/autostart.sh" || true

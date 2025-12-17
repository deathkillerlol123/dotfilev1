#!/bin/bash

rm -rf ~/.cache/*
mkdir ~/.cache/swww

sudo rm -rf ~/.local/share/Trash/*

flatpak uninstall --unused

sudo rm -rf /tmp/* /var/cache/fontconfig/* /var/cache/man/*

#yarn cache clean
cargo clean

rm -rf ~/.cargo/registry
rm -rf ~/.cargo/git

sudo pacman -Sc
sudo pacman -Scc

sudo journalctl --vacuum-time=7d

rm -rf ~/.cache/* ~/.cargo/{registry,git} ~/.var/app/*/cache ~/.mozilla/firefox/*/cache2/*
#yarn cache clean --silent

sudo rm -rf /var/tmp/*
sudo rm -rf /tmp/*

sudo rm -rf /var/cache/pacman/pkg/*

~/dotfiles/scripts/tester.sh

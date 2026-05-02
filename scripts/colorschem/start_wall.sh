#!/usr/bin/env bash

cd ~/dotfiles/nixos/themes/limine_wallpaper/
value="$(ls)"

swww img "$value" --transition-type outer --transition-step 90

echo $value

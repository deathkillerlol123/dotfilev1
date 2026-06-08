#!/usr/bin/env bash
cd ~/dotfiles/nixos/bootloader/
value="$(ls)"
swww img "$value" --transition-type fade --transition-step 90 --transition-duration 7 &

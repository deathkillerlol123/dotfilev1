#!/usr/bin/env bash
win_boot=$(efibootmgr | awk -F'Boot|\\*' '/Windows Boot Manager/ {print $2; exit}')
if [[ -n "$win_boot" ]]; then
    sudo efibootmgr -n "$win_boot"
    sudo reboot
else
    echo "Windows Boot Manager entry not found."
    exit 1
fi

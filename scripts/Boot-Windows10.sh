#!/usr/bin/env bash
BOOTNUM=$(efibootmgr | grep -i "Windows Boot Manager" | sed -E 's/^Boot([0-9A-Fa-f]+).*/\1/')
sudo efibootmgr -n "$BOOTNUM"
sudo reboot

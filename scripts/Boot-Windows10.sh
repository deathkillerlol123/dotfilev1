#!/usr/bin/env bash
sudo efibootmgr -n "$(efibootmgr | awk '/Windows Boot Manager/{sub(/^Boot/,"",$1); print $1}')" && sudo reboot

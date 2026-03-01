#!/usr/bin/env bash
# Switch boot order to Windows and reboot
sudo efibootmgr -n 0001
sudo reboot

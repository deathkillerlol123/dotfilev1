#!/usr/bin/env bash
latest=$(ls -t ~/Pictures/Screenshots | head -1)
feh "$HOME/Pictures/Screenshots/$latest"

#!/usr/bin/env bash

# Set DP (left) and HDMI (right) without setting primary
wlr-randr --output DP-1 --mode 1920x1080 --pos 0,0 --transform 90
wlr-randr --output DP-2 --mode 1920x1080 --pos 0,0 --transform 90

wlr-randr --output HDMI-A-1 --mode 1920x1080 --pos 1080,0
wlr-randr --output eDP-1 --mode 1920x1080 --pos 1080,1080

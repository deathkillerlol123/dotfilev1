#!/usr/bin/env fish

# Set DP (left) and HDMI (right) without setting primary

wlr-randr --output HDMI-A-1 --mode 1920x1080 --pos 0,0 --on

wlr-randr --output DP-1 --mode 1920x1080 --pos 1920,0 --on
wlr-randr --output DP-2 --mode 1920x1080 --pos 1920,0 --on

wlr-randr --output eDP-1 --mode 1920x1080 --pos 1920,1080 --off

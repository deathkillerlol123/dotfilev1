#pgrep -f waybar >/dev/null && pkill -f waybar || waybar &

pkill waybar
waybar &

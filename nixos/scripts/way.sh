#pgrep -f waybar >/dev/null && pkill -f waybar || waybar &

pkill waybar
sleep 0.5
waybar &

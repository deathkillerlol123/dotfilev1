swww-daemon &

copyq &
hyprpm reload
swaync &

sleep 1

"$HOME/dotfiles/scripts/colorschem/start_wall.sh"

sleep 1

"$HOME/dotfiles/scripts/niri_monitors/placement.sh"

sleep 1

"$HOME/dotfiles/scripts/disable-wifi-power.sh"

swww-daemon &

"$HOME/dotfiles/scripts/colorschem/start_wall.sh"
"$HOME/dotfiles/scripts/disable-wifi-power.sh"
"$HOME/dotfiles/scripts/niri_monitors/placement.sh"

wayscriber --daemon &
copyq &
hyprpm reload
dunst &

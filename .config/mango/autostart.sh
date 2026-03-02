swww-daemon &

brightnessctl s 15%

copyq &
hyprpm reload
swaync &

"$HOME/dotfiles/scripts/niri_monitors/placement.sh"

"$HOME/dotfiles/scripts/colorschem/start_wall.sh"

"$HOME/dotfiles/scripts/disable-wifi-power.sh"

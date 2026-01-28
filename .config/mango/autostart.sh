swww-daemon &

"$HOME/dotfiles/scripts/colorschem/start_wall.sh"
"$HOME/dotfiles/scripts/disable-wifi-power.sh"

wayscriber --daemon &
copyq &
hyprpm reload
dunst &

"$HOME/dotfiles/scripts/sys_sounds/sound_mon.sh"

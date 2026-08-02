systemctl --user restart pipewire pipewire-pulse
sink="alsa_output.pci-0000_00_1f.3.hdmi-stereo-extra1"
pactl set-default-sink "$sink"
pactl list short sink-inputs | awk '{print $1}' | while read -r i; do
  pactl move-sink-input "$i" "$sink"
done

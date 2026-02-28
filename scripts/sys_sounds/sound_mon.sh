systemctl --user restart pipewire pipewire-pulse
pactl set-default-sink alsa_output.pci-0000_00_1f.3.hdmi-stereo-extra1
for i in $(pactl list short sink-inputs | awk '{print $1}'); do pactl move-sink-input $i alsa_output.pci-0000_00_1f.3.hdmi-stereo-extra1; done

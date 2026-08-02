#!/usr/bin/env bash
set -e
exec 9>/tmp/random_wallpaper.lock
DIRS="$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home/"
COLORS="$HOME/.cache/wal"
FINALOUTPUT="$DIRS/.config"
flock -n 9 || exit 0
pkill -x rofi -u "$USER" || true
cd "$DIRS/.config/waybar/"
FILE=$(find "$HOME/Pictures/Wallpapers/" -type f -print0 | shuf -zn1)
echo "$FILE"
if [ -n "$FILE" ]; then
    wal -i "$FILE"
    cp "$HOME/.cache/wal/ghostty.conf" \
       "$DIRS/.config/ghostty/ghostty.conf"
    cp "${COLORS}/colors-waybar.css" \
       "${FINALOUTPUT}/waybar/colors.css"
    INPUT="${FINALOUTPUT}/waybar/colors.css"
    OUTPUT_RASI="${FINALOUTPUT}/rofi/colors.rasi"
    {
        echo "* {"
        grep '@define-color' "$INPUT" | while read -r line; do
            name=$(echo "$line" | awk '{print $2}')
            value=$(echo "$line" | awk '{print $3}' | tr -d ';')
            echo "    $name: $value;"
        done
        echo "}"
    } > "$OUTPUT_RASI"
    cd "$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home/Wallpapers/"
    rm -rf ./*
    cp "$FILE" "$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home/Wallpapers/"
fi

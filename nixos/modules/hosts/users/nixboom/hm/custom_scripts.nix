{...}: {
  flake.homeModules.custom_scripts = {pkgs, ...}: {
    home.packages = [
      (pkgs.writeShellScriptBin "volume_increase" ''
        amixer set Master 5%+
      '')
      (pkgs.writeShellScriptBin "volume_decrease" ''
        amixer set Master 5%-
      '')
      (pkgs.writeShellScriptBin "volume_mute" ''
        amixer set Master toggle
      '')
      (pkgs.writeShellScriptBin "clean_exit" ''
        loginctl terminate-session "$XDG_SESSION_ID"
      '')
      (pkgs.writeShellScriptBin "backup" ''
        set -euo pipefail
        REPO="/mnt/Backups/nixos_backups"
        BACKUP_NAME="$(date +%Y-%m-%d_%H-%M-%S)"
        echo "Starting Borg backup: $BACKUP_NAME"
        borg create \
          --progress \
          --stats \
          --compression zstd \
          "$REPO::$BACKUP_NAME" \
          --exclude 'sh:**/Downloads/*.iso' \
          --exclude 'sh:**/Downloads/*.tar.gz' \
          --exclude 'sh:**/Downloads/tmp*' \
          --exclude 'sh:**/Documents/tmp*' \
          --exclude 'sh:**/Documents/codes/venv' \
          --exclude 'sh:**/Downloads/isoss' \
          "$HOME/Documents" \
          "$HOME/Downloads" \
          "$HOME/Pictures/Screenshots" \
          "$HOME/dotfiles"
        echo "Pruning old backups..."
        borg prune \
          --list \
          --keep-daily=7 \
          --keep-weekly=4 \
          --keep-monthly=60 \
          "$REPO"
        echo "Updating backup list..."
        echo borg list "$REPO"
        echo "Unmounting backup drive..."
        sync
        sudo umount /mnt/Backups
        echo "Backup complete."
      '')
      (pkgs.writeShellScriptBin "random-wallpaper" ''
        set -e
        exec 9>/tmp/random_wallpaper.lock
        DIRS="$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home"
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
          cp "$COLORS/colors-waybar.css" \
            "$FINALOUTPUT/waybar/colors.css"
          INPUT="$FINALOUTPUT/waybar/colors.css"
          OUTPUT_RASI="$FINALOUTPUT/rofi/colors.rasi"
          {
            echo "* {"
            grep '@define-color' "$INPUT" |
              while read -r line; do
                name=$(echo "$line" | awk '{print $2}')
                value=$(echo "$line" | awk '{print $3}' | tr -d ';')
                echo "    $name: $value;"
              done
            echo "}"
          } > "$OUTPUT_RASI"
          cd "$DIRS/Wallpapers/"
          rm -rf ./*
          cp "$FILE" "$DIRS/Wallpapers/"
        fi
      '')
    ];
  };
}

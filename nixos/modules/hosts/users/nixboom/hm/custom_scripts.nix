{...}: {
  flake.homeModules.nbcustom_scripts = {pkgs, ...}: {
    home.packages = [
      (pkgs.writeShellScriptBin "volume_increase" ''
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      '')
      (pkgs.writeShellScriptBin "volume_decrease" ''
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      '')
      (pkgs.writeShellScriptBin "volume_mute" ''
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
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
        pkill -x fuzzel -u "$USER" || true
        FILE=$(find "$HOME/Pictures/Wallpapers/" -type f -print0 | shuf -zn1)
        if [ -z "$FILE" ]; then
          echo "No wallpapers found" >&2
          exit 1
        fi
        echo "$FILE"
        wal -i "$FILE"
        cp "$COLORS/ghostty.conf" \
          "$DIRS/.config/ghostty/ghostty.conf"
        cp "$COLORS/colors-waybar.css" \
          "$FINALOUTPUT/waybar/colors.css"
        cp "$COLORS/colors-fuzzel.ini" \
          "$DIRS/.config/fuzzel/fuzzel.ini"
        cd "$DIRS/Wallpapers"
        rm -f -- ./*
        cp -- "$FILE" .
      '')
    ];
  };
}

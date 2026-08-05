#!/usr/bin/env bash

set -euo pipefail

REPO="/mnt/Backups/ArchB/BorgBackups2"
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

borg list "$REPO" > "$HOME/list.txt"

echo "Unmounting backup drive..."

sync
sudo umount /mnt/Backups

echo "Backup complete."

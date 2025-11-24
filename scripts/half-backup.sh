duplicity incremental --no-encryption \
  --include /home/archboom/Documents \
  --include /home/archboom/Downloads \
  --include /home/archboom/Pictures/Screenshots \
  --include /home/archboom/dotfiles \
  --include "/home/archboom/.local/share/Anki2/User 1/backups" \
  --exclude '**' \
  / "file:///mnt/Backups/Linux backups/"

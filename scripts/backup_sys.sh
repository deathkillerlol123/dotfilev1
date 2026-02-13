borg create --progress "/mnt/Backups/ArchB/BorgBackups2::$(date +%Y-%m-%d_%H-%M-%S)" \
  --exclude '/home/archboom/Downloads/*.iso' \
  --exclude '/home/archboom/Downloads/*.tar.gz' \
  --exclude '/home/archboom/Downloads/tmp*' \
  --exclude '/home/archboom/Documents/tmp*' \
  --exclude '/home/archboom/dotfiles/.git' \
  --exclude '/home/archboom/dotfiles/.gitignore' \
  --exclude '/home/archboom/Documents/codes/venv/' \
  --exclude '/home/archboom/Downloads/isoss/' \
  /home/archboom/Documents \
  /home/archboom/Downloads \
  /home/archboom/Pictures/Screenshots \
  /home/archboom/dotfiles \
  "/home/archboom/.local/share/Anki2/User 1/backups"

borg list /mnt/Backups/ArchB/BorgBackups2/

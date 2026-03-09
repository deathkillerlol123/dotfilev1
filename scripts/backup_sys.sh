borg create --progress "/mnt/Backups/ArchB/BorgBackups2::$(date +%Y-%m-%d_%H-%M-%S)" \
  --exclude '~/Downloads/*.iso' \
  --exclude '~/Downloads/*.tar.gz' \
  --exclude '~/Downloads/tmp*' \
  --exclude '~/Documents/tmp*' \
  --exclude '~/dotfiles/.git' \
  --exclude '~/dotfiles/.gitignore' \
  --exclude '~/Documents/codes/venv/' \
  --exclude '~/Downloads/isoss/' \
  --exclude '~/dotfiles/.mozilla' \
  ~/Documents \
  ~/Downloads \
  ~/Pictures/Screenshots \
  ~/dotfiles

borg list /mnt/Backups/ArchB/BorgBackups2/

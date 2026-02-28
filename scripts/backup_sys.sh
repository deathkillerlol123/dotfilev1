borg create --progress "/mnt/Backups/ArchB/BorgBackups2::$(date +%Y-%m-%d_%H-%M-%S)" \
  --exclude '/home/nixboom/Downloads/*.iso' \
  --exclude '/home/nixboom/Downloads/*.tar.gz' \
  --exclude '/home/nixboom/Downloads/tmp*' \
  --exclude '/home/nixboom/Documents/tmp*' \
  --exclude '/home/nixboom/dotfiles/.git' \
  --exclude '/home/nixboom/dotfiles/.gitignore' \
  --exclude '/home/nixboom/Documents/codes/venv/' \
  --exclude '/home/nixboom/Downloads/isoss/' \
  --exclude '/home/nixboom/dotfiles/.mozilla' \
  /home/nixboom/Documents \
  /home/nixboom/Downloads \
  /home/nixboom/Pictures/Screenshots \
  /home/nixboom/dotfiles \

borg list /mnt/Backups/ArchB/BorgBackups2/

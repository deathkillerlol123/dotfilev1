borg create --progress "/mnt/Backups/ArchB/BorgBackups2::$(date +%Y-%m-%d_%H-%M-%S)" \
  --exclude "$HOME/Downloads/*.iso" \
  --exclude "$HOME/Downloads/*.tar.gz" \
  --exclude "$HOME/Downloads/tmp*" \
  --exclude "$HOME/Documents/tmp*" \
  --exclude "$HOME/dotfiles/.git" \
  --exclude "$HOME/dotfiles/.gitignore" \
  --exclude "$HOME/Documents/codes/venv" \
  --exclude "$HOME/Downloads/isoss" \
  ~/Documents \
  ~/Downloads \
  ~/Pictures/Screenshots \
  ~/dotfiles

borg list /mnt/Backups/ArchB/BorgBackups2/
borg list /mnt/Backups/ArchB/BorgBackups2/ >~/list.txt
sudo umount /mnt/Backups/

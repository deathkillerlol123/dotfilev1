sudo umount /mnt/Wonly
sudo umount /mnt/SteamLibrary/
#sudo umount /mnt/Backups/

sudo mkdir -p /mnt/Wonly
sudo mkdir -p /mnt/SteamLibrary/
#sudo mkdir -p /mnt/Backups/

sudo mount -t ntfs-3g -o uid=$(id -u),gid=$(id -g) /dev/sda1 /mnt/Wonly
sudo mount -t ext4 /dev/sda2 /mnt/SteamLibrary
#sudo mount /dev/sdc1 /mnt/Backups

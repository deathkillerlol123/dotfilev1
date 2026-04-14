{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ly
    efibootmgr
    os-prober

    curl
    wget

    libimobiledevice
    git
    gh

    libnotify
    brightnessctl
    borgbackup
    ntfs3g
    smartmontools    

    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    wlr-randr
  ];
}
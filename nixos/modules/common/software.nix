{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ly
    efibootmgr
    os-prober

    curl
    wget

    libimobiledevice
    fahclient

    mangohud
    winetricks
    protonup-qt
    heroic
    gamescope
    gamemode

    brightnessctl
    wlr-randr
    borgbackup
    wdisplays   
    quickshell
    eww

    xev
    git
    gh
    dysk
    libnotify

    swaynotificationcenter
    swaybg
    swaylock
    nautilus  
    rofi
    bzmenu
    pwmenu
    bemoji
    waybar

    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr

    firefox-devedition
    qutebrowser
#    ladybird
    whatsapp-electron
    discord
    wezterm
    starship
    bash
    fish

    neovim
    zoxide
    emacs

    yazi
    copyq
    grim
    slurp
    swappy
    wl-clipboard
    eza
    bat
    btop
    cmatrix
    fastfetch
    swww
    fd
    pywal
    viu
    ntfs3g
    smartmontools
    qbittorrent

    mangowc
    glibc
    wayland
    wayland-protocols
    libinput
    libdrm
    libxkbcommon
    pixman
    meson
    gcc
    ninja
    gnumake
    rustc
    cargo
    raylib
    libdisplay-info
    seatd
    pcre2
    python315
    pipx
 ];
}

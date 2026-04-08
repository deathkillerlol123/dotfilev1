{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ly
    efibootmgr
    os-prober

    curl
    wget
    nodejs_24

    evtest
    libimobiledevice
    fahclient

    mangohud
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
    wlogout
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
    nixd
    nil

    yazi
    copyq
    grim
    slurp
    wl-clipboard
    eza
    btop
    cmatrix
    neofetch
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

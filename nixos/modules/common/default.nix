{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ly
    efibootmgr
    os-prober
    curl 

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
    
    zellij
    viu
    copyq
    grim
    slurp
    wl-clipboard
    swappy 
    bat
    eza
    btop
    cmatrix
    clock-rs
    neofetch
    swww
    fd
    pywal
    kdePackages.gwenview  
    ntfs3g
    
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

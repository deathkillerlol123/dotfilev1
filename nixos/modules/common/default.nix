{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ly
    efibootmgr
    os-prober
    curl 
    wget    
    mangohud
    protonup-qt
    heroic
    gamescope
    gamemode
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk

    uxplay

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
    waybar
    
    firefox-devedition
    whatsapp-electron
    discord-ptb
    kitty
    
    wezterm
    starship
    bash
    fish
    
    zoxide
    neovim
    emacs
    yazi
    
    zed-editor
    zellij
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

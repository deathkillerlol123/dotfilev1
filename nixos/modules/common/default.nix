{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gdm
    ly
    efibootmgr
    os-prober
    lm_sensors
    curl 
    wget    
 		xdg-desktop-portal-hyprland
		xdg-desktop-portal-gtk
		xdg-desktop-portal-wlr
    mangohud
    protonup-qt
    heroic
    #bottles
    lutris
    gamescope
    gamemode
    
    nix-search-cli
    brightnessctl
    mpv
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
    stasis
    wlogout
    nautilus  
    rofi
    
    dmenu
    waybar
    ironbar
    
    qutebrowser
    firefox-devedition  
    whatsapp-electron
    discord-ptb
    kitty
    
    wezterm
    starship
    zsh
    bash
    fish
    
    zoxide
    neovim
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
    ranger
    swww
    pywal
    kdePackages.gwenview  
    lyra-cursors
    
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
    hwdata
    seatd
    pcre2
    python315
    pipx
  ];
  
}

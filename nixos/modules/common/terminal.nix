{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wezterm
    starship
    bash
    fish
    neovim
    zoxide
    emacs
    yazi
    eza
    bat
    dysk    
    btop
    bottom
    cmatrix
    fastfetch
    fd
    viu
    clock-rs
  ];
}
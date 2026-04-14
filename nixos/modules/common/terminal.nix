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
    cmatrix
    fastfetch
    fd
    viu    
  ];
}
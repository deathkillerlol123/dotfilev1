{inputs,...}:{
  flake.nixosModules.system = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      ly
      efibootmgr
      os-prober  
      curl
      git
      gh
      libnotify
      brightnessctl
      borgbackup
      ntfs3g
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      wlr-randr

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
      bottom
      cmatrix
      fastfetch
      fd
      viu
      clock-rs
    ];
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.dejavu-sans-mono
    ];
  };
}
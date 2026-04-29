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
      statix
      cachix
    ];
    fonts.packages = with pkgs; with nerd-fonts; [
      fira-code
      droid-sans-mono
      dejavu-sans-mono      
    ];
   };
}
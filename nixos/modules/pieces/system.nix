{inputs,...}:{
  flake.nixosModules.system = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      ly
      efibootmgr
      os-prober  
      curl
      zip
      git
      gh
      libnotify
      brightnessctl
      borgbackup
      ntfs3g
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      starship
      bash
      fish
      zoxide
      emacs
      yazi
      eza
      bat
      bottom
      fastfetch
      fd
      statix
      nix-output-monitor
      ];
    fonts.packages = with pkgs; with nerd-fonts; [
      fira-code
      droid-sans-mono
      dejavu-sans-mono      
    ];
   };
}
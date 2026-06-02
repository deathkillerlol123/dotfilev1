{inputs,...}:{
  flake.nixosModules.system = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      ly
      os-prober
      efibootmgr
      curl
      zip
      git
      gh
      libnotify
      brightnessctl
      borgbackup
      ntfs3g
      wlr-randr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      starship
      bash
      fish
      zoxide
      emacs
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
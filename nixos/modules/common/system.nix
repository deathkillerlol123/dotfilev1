{inputs,...}:{
  flake.nixosModules.system = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      ly
      efibootmgr
      os-prober
  
      curl
      wget
  
      git
      gh
  
      libnotify
      brightnessctl
      borgbackup
      ntfs3g
      smartmontools
      stress-ng
  
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      wlr-randr
    ];
  };
}

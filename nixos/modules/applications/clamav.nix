{inputs,pkgs,...}:{
  flake.nixosModules.clamav = {pkgs,...}:{
    environment.systemPackages = [pkgs.clamav];
    services.clamav.daemon.enable = true;
    services.clamav.updater.enable = true;
  };
}
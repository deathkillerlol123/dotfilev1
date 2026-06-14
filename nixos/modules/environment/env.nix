{inputs,...}:{
  flake.nixosModules.environment = {pkgs, ... }: {
    services = {
      desktopManager = {
        plasma6.enable = false;
        gnome.enable = false;
      };
    };
  };
}

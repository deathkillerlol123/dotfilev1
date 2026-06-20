{inputs,...}:{
  flake.nixosModules.kde = {pkgs, ... }: {
    services = {
      desktopManager = {
        plasma6.enable = true;
      };
    };
  };
}

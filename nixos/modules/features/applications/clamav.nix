{...}: {
  flake.nixosModules.clamav = {
    pkgs,
    lib,
    ...
  }: let
    enabledservices = names:
      lib.genAttrs names (_: {
        enable = true;
      });
  in {
    environment.systemPackages = [pkgs.clamav];
    services.clamav = enabledservices ["daemon" "updater"];
  };
}

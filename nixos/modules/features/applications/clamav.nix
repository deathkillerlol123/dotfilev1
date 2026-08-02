{...}: {
  flake.nixosModules.clamav = {
    pkgs,
    lib,
    config,
    ...
  }: let
    enabledservices = names:
      lib.genAttrs names (_: {
        enable = true;
      });
  in {
    options.clamav.enable = lib.mkEnableOption "clamav";
    config = lib.mkIf config.clamav.enable {
      environment.systemPackages = [pkgs.clamav];
      services.clamav = enabledservices ["daemon" "updater"];
    };
  };
}

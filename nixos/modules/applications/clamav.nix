{_}:
let
  enabledservices =
    names:
    lib.genAttrs names (_: {
      enable = true;
    });
in
{
  flake.nixosModules.clamav =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.clamav ];
      services.clamav = enabledservices [
        "daemon"
        "updater"
      ];
    };
}

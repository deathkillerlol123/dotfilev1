{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  flake.nixosModules.helium =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = [
          inputs.helium.packages.${pkgs.system}.default
        ];
      };
    };
}

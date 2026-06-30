{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  flake.nixosModules.discord =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nixcord.nixosModules.nixcord ];
      programs.nixcord = {
        enable = true;
        discord = lib.mkForce { enable = false; };
        vesktop.enable = true;
        user = "username_right_here";
      };
    };
}

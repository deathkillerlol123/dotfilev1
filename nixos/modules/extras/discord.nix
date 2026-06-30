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
        discord.equicord.enable = true; 
        user = "nixboom";
      };
    };
}

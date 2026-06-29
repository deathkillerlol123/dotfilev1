{ config,self,lib, ... }:
{
  flake.nixosModules.fish =
    { config,self,lib,pkgs, ... }:
    {
      programs.fish = {
        enable = true;
      };
      environment.systemPackages = [ pkgs.fish ];
    };
}

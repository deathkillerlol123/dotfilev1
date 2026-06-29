{ config,self,lib, ... }:
let
  shared = import self.nixosModules.alias;
in    
{
  flake.nixosModules.fish =
    { config,self,lib,pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        shellAliases = shared.shellAliases;
      };
      environment.systemPackages = [ pkgs.fish ];
    };
}

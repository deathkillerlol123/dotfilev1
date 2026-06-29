{ config,self,lib, ... }:
{
  flake.nixosModules.fish =
    { self,lib,pkgs, ... }:
    {
      imports = [ self.nixosModules.alias ];
      programs.fish = {
        enable = true;
        shellAliases = config.alias.lib.shellAliases;
      };
      environment.systemPackages = [ pkgs.fish ];
    };
}

{ config,self,lib, ... }:
{
  flake.nixosModules.fish =
    { config,self,lib,pkgs, ... }:
    {
      imports = [self.nixosModules.alias];
      programs.fish = {
        enable = true;
      };
      environment.systemPackages = [ pkgs.fish ];
    };
}

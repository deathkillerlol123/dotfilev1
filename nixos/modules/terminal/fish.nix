{ self, ... }:
{
  flake.nixosModules.fish =
    { pkgs, ... }:
    {
      imports = [ self.nixosModules.alias ];
      programs.fish = {
        enable = true;
        shellAliases = self.nixosModules.alias.lib.shellAliases;
      };
      environment.systemPackages = [ pkgs.fish ];
    };
}

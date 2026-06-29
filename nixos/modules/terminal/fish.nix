{ self, ... }:
{
  flake.nixosModules.fish =
    { pkgs, ... }:
    {
      imports = [ alias ];
      programs.fish = {
        enable = true;
        shellAliases = self.lib.shellAliases;
      };
      environment.systemPackages = [ pkgs.fish ];
    };
}

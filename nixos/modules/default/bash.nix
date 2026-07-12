{self,... }:
{
  flake.nixosModules.bash =
    {
      programs.bash = {
        enable = true;
      };
    };
}

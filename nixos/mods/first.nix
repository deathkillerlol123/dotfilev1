{inputs,...}:
{
  flake.nixosModules.first = { pkgs,...}: {
    programs.firefox.enable = true;
  };
}
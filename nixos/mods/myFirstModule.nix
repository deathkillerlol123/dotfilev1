{inputs,...}:
{
  flake.nixosModules.myFirstModule = { pkgs,...}: {
    programs.firefox.enable = true;
  };
}
{moduleWithSystem, ...}: {
  flake.nixosModules.wshowkeys = moduleWithSystem ({
    pkgs,
    self',
    ...
  }: {
    programs.wshowkeys = {
      enable = true;
      package = self'.packages.wshowkeys;
    };
  });
  perSystem = {inputs', ...}: {
    packages = {
      wshowkeys = inputs'.wshowkeys.packages.default;
    };
  };
}

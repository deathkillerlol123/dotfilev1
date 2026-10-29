{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.btop = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [self'.packages.btop];
  });
  perSystem = {pkgs, ...}: {
    packages.btop = inputs.wrappers.wrappers.btop.wrap {
      inherit pkgs;
      settings = {
        color_theme = "ayu";
        vim_keys = true;
      };
    };
  };
}

,
  inputs,
  ...
}: {
  flake.nixosModules.wshowkeys = moduleWithSystem ({self', ...}: {
    programs.wshowkeys = {
      enable = true;
      package = self'.packages.wshowkeys;
    };
  });

  perSystem = {
    inputs',
    pkgs,
    ...
  }: {
    packages.wshowkeys = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = inputs'.wshowkeys.packages.default;
      flags = {
        "-a" = "bottom";
        "-F" = "Maple Mono NF 30";
        "-s" = "#B5B520ff";
        "-f" = "#ecd29cff";
        "-b" = "#201B1488";
        "-l" = "600";
        "-t" = "300";
        "-U" = true;
        "-S" = true;
      };
    };
  };
}

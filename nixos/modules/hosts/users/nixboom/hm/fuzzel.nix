{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  flake.nixosModules.nbfuzzel = {
    config,
    inputs,
    lib,
    pkgs,
    ...
  }: {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          width = 45;
          lines = 12;
          font = "Maple Mono NF";
          horizontal-pad = 20;
          vertical-pad = 10;
          inner-pad = 5;
        };
      };
    };
  };
}

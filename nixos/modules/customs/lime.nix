{...}: {
  flake.nixosModules.lime = {
    config,
    lib,
    ...
  }: {
    options.lime.maxgen = lib.mkOption {
      default = 3;
    };
    config = {
      boot = {
        loader = {
          efi.canTouchEfiVariables = true;
          limine = {
            enable = true;
            maxGenerations = config.lime.maxgen;
          };
        };
      };
    };
  };
}

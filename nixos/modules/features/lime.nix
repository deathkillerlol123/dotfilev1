{...}: {
  flake.nixosModules.lime = {
    lib,
    config,
    ...
  }: {
    options = {
      lime.enable = lib.mkEnableOption "limine";
      lime = {
        generations = lib.mkOption {
          default = 3;
          description = "How many nixos generations to show up in limine";
        };
        params = lib.mkOption {
          default = [""];
          description = "What kernel parameters are being applied";
        };
      };
    };
    config = lib.mkIf config.lime.enable {
      boot = {
        kernelParams = config.lime.params;
        loader = {
          efi.canTouchEfiVariables = true;
          limine = {
            enable = true;
            maxGenerations = config.lime.generations;
          };
        };
      };
    };
  };
}

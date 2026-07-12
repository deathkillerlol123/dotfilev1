{ self, ... }: {
  flake.nixosModules.lime = { lib, config, ... }: {
    options = {
      lime.enable = lib.mkEnableOption "limine";
      lime = {
        generations = lib.mkOption {
          default = 3;
        };
        params = lib.mkOption {
          default = [ "" ];
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

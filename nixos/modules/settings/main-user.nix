{lib,config,pkgs,...}:{
  options  = {
    main-users = lib.mkOption {
      default = {};
      type = lib.types.attrsOf (lib.types.submodule ({ ... }: {
        options = {
          enable = lib.mkEnableOption "enable user module";
          shell = lib.mkOption {
            default = "bash";
          };
          flakelocation = lib.mkOption {
            default = "/etc/nixos/";
          };
          groups = lib.mkOption {
            default = ["wheel"];
          };
        };
      }));
    };
  };

  config = lib.mkMerge (
    lib.mapAttrsToList (name: userCfg:
      lib.mkIf userCfg.enable {
        users.users.${name} = {
          isNormalUser = true;
          shell = pkgs.${userCfg.shell};
          extraGroups = userCfg.groups;
        };

        security = {
          sudo.extraRules = [{
            users = [name];
            commands = [{ command = "ALL";
              options = ["NOPASSWD"];
            }];
          }];
        };

        programs = {
          ${userCfg.shell}.enable = true;
          nh = {
            enable = true;
            clean.enable = true;
            flake = userCfg.flakelocation;
          };
          nix-ld = {
            enable = true;
          };
        };
      }
    ) config.main-users
  );
}
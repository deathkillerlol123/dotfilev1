{ inputs, self, ... }:
{
  flake.nixosModules.users = { lib, config, pkgs, ... }:

  let
    cfg = config.usersConfig;
  in
  {
    options.usersConfig = {
      enable = lib.mkEnableOption "enable multi-user module";

      users = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule ({ name, ... }: {
          options = {
            shell = lib.mkOption {
              type = lib.types.str;
              default = "bash";
            };

            groups = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [];
            };
          };
        }));

        default = {};
        description = "Attribute set of users to create on the system";
      };
    };

    config = lib.mkIf cfg.enable {

      # -------------------------
      # Users
      # -------------------------
      users.users = lib.mapAttrs (name: u: {
        isNormalUser = true;
        shell = lib.getAttr u.shell pkgs;
        extraGroups = u.groups;
      }) cfg.users;

      # -------------------------
      # Sudo rules (passwordless)
      # -------------------------
      security.sudo.extraRules =
        lib.mapAttrsToList (name: _: {
          users = [ name ];
          commands = [{
            command = "ALL";
            options = [ "NOPASSWD" ];
          }];
        }) cfg.users;

      # -------------------------
      # Programs
      # -------------------------
      programs =
        {
          nh = {
            enable = true;
            clean.enable = true;
            flake = self.outPath;
          };

          nix-ld.enable = true;
        }

        # Enable fish only if any user uses it
        // lib.optionalAttrs
          (lib.any (u: u.shell == "fish") (lib.attrValues cfg.users))
          {
            fish.enable = true;
          };
    };
  };
}
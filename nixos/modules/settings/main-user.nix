{ self, ... }:
{
  flake.nixosModules.main-user =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      options.main-user.users = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule (
            { name, ... }:
            {
              options = {
                enable = lib.mkEnableOption "enable user module";

                shell = lib.mkOption {
                  type = lib.types.str;
                  default = "fish";
                };

                groups = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  default = [ "wheel" ];
                };
              };
            }
          )
        );
      };

      config =
        let
          cfg = config.main-user.users;
          enabledUsers = lib.filterAttrs (_: u: u.enable) cfg;

          shells = lib.unique (map (u: u.shell) (lib.attrValues enabledUsers));

        in
        {
          users.users = lib.mapAttrs (name: u: {
            isNormalUser = true;
            shell = pkgs.${u.shell};
            extraGroups = u.groups;
          }) enabledUsers;

          security.sudo.extraRules = lib.mapAttrsToList (name: _: {
            users = [ name ];
            commands = [
              {
                command = "ALL";
                options = [ "NOPASSWD" ];
              }
            ];
          }) enabledUsers;

          programs = lib.mkMerge [
            {
              nh = {
                enable = true;
                flake = self.outPath;
                clean = {
                  enable = true;
                  extraArgs = "--keep 3";
                };
              };

              nix-ld.enable = true;
            }

            (lib.genAttrs shells (_: {
              enable = true;
            }))
          ];
        };
    };
}

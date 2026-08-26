{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.main-user = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.main-user.users;

    enabledUsers =
      lib.filterAttrs (_: u: u.enable) cfg;

    shells =
      lib.unique (map (u: u.shell) (lib.attrValues enabledUsers));
  in {
    imports =
      [inputs.home-manager.nixosModules.home-manager]
      ++ lib.mapAttrsToList
      (name: _: self.nixosModules.${name})
      enabledUsers;

    options.main-user.users = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule (
          {name, ...}: {
            options = {
              enable = lib.mkEnableOption "enable user";

              shell = lib.mkOption {
                type = lib.types.str;
                default = "fish";
                description = "shell type for the user";
              };

              groups = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = ["wheel"];
                description = "Groups that the user is in";
              };
            };
          }
        )
      );
    };

    config = {
      users.users =
        lib.mapAttrs (name: u: {
          isNormalUser = true;
          shell = pkgs.${u.shell};
          extraGroups = u.groups;
        })
        enabledUsers;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          inherit inputs self;
        };

        users =
          lib.mapAttrs
          (name: _: self.homeModules.${name})
          enabledUsers;
      };

      security.sudo.extraRules =
        lib.mapAttrsToList (name: _: {
          users = [name];
          commands = [
            {
              command = "ALL";
              options = ["NOPASSWD"];
            }
          ];
        })
        enabledUsers;

      programs = lib.mkMerge [
        {
          nh = {
            enable = true;
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

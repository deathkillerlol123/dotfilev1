{ inputs, self, ... }:
{
  flake.nixosModules.home-man =
    { lib, config, ... }:
    let
      cfg = config.home-man;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      options.home-man = {
        enable = lib.mkEnableOption "Home Manager";

        backupFileExtension = lib.mkOption {
          type = lib.types.str;
          default = "backup";
        };

        users = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          example = [ "nixboom" "doct" ];
        };
      };

      config = lib.mkIf cfg.enable {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          backupFileExtension = cfg.backupFileExtension;

          extraSpecialArgs = {
            inherit inputs self;
          };

          users = lib.genAttrs cfg.users
            (username:
              import "${self.outPath}/modules/hosts/users/${username}/_home.nix");
        };
      };
    };
}
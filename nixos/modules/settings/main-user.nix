{lib,config,pkgs,...}:
{
  options  = {
    main-user.enable = lib.mkEnableOption "enable user module";
    main-user = {
      userName = lib.mkOption {
        default = "mainuser";
      };
      shell = lib.mkOption {
        default = "bash";
      };
      flake-location = lib.mkOption {
        default = "/etc/nixos/";
      };	
    };
  };
  config = lib.mkIf config.main-user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      shell = pkgs.${config.main-user.shell};
    };
    security = {
      sudo.extraRules = [{
        users = [config.main-user.userName];
        commands = [{ command = "ALL";
          options = ["NOPASSWD"];
        }];
      }];
    };
    programs = {
      ${config.main-user.shell}.enable = true;
      nh = {
        enable = true;
	clean.enable = true;
	flake = config.main-user.flake-location;
      };
      nix-ld = {
        enable = true;
      };
    };
 };
}
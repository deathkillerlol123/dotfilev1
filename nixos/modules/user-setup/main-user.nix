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
      cleaner = {
        generations = lib.mkOption {
	  default = "3";
      	};
	flake_location = lib.mkOption {
	  default = "/tmp";
	};
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
        clean.extraArgs = "--keep ${config.main-user.cleaner.generations}";
        flake = config.main-user.cleaner.flake_location;
      };
      nix-ld = {
        enable = true;
      };      
    };    
 };
}
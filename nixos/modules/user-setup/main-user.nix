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
	default=3
      };
    };
  };
  config = lib.mkIf config.main-user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      shell = pkgs.${config.main-user.shell};
    };
    programs = {
      ${config.main-user.shell}.enable = true;
    };
    security = {
      sudo.extraRules = [{
        users = [config.main-user.userName];
        commands = [{ command = "ALL";
          options = ["NOPASSWD"];
        }];
      }];
    };   
 };
}
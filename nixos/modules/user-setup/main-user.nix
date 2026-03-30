{lib,config,pkgs,...}:
{
  options  = {
    main-user.enable = lib.mkOption "enable user module";
    main-user.userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
  };
  config = lib.mkIF config.main-user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      shell = pkgs.fish;
    };
  };
}
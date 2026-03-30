{lib,config,pkgs,...}:
{
  options  = {
    main-user.userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
  };
  users.users.${config.main-user.userName} = {
    isNormalUser = true;
    shell = pkgs.fish;
}
{lib,config,pkgs,...}:
{
  options = {
    main-users.enable = lib.mkEnableOption "enable users module";

    main-users.users = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          userName = lib.mkOption {
	    default = "user";
	  };
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
      });
      default = [];
      description = "List of users to create";
    };
  };
  config = lib.mkIf config.main-users.enable {
    users.users = lib.listToAttrs (map (u: {
      name = u.userName;
      value = {
        isNormalUser = true;
        shell = pkgs.${u.shell};
        extraGroups = u.groups;
      };
    }) config.main-users.users);
  
    security.sudo.extraRules = lib.concatMap (u: [{
      users = [u.userName];
      commands = [{
        command = "ALL";
        options = ["NOPASSWD"];
      }];
    }]) config.main-users.users;
  
    programs = lib.listToAttrs (map (u: {
      name = u.shell;
      value = { enable = true; };
    }) config.main-users.users);
  
    # The nh program for each user (optional, keeps original style)
    nh = lib.listToAttrs (map (u: {
      name = u.userName;
      value = {
        enable = true;
        clean.enable = true;
        flake = u.flakelocation;
      };
    }) config.main-users.users);
  
    nix-ld.enable = true;
  };
}
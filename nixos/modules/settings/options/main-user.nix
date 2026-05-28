{inputs,self,...}:{
  flake.nixosModules.main-user = {lib,config,pkgs,...}:{
    options.main-user.users= lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule ({ name, ... }: {
        options = {
	  enable = lib.mkEnableOption "enable user module";
	  shell = lib.mkOption {
	    type = lib.types.nullOr lib.types.package;
	    default = null;	  
	  };
	  groups = lib.mkOption {
	    type = lib.types.listOf lib.types.str;
            default = ["wheel"];
	  };
        };
      }));
    };
    config = let
      cfg = config.main-user.users;
      enabledUsers = lib.filterAttrs (_: u: u.enable) cfg;
    in {
      users.users = lib.mapAttrs (name: u: {
        isNormalUser = true;
	shell = if u.shell == null then pkgs.fish else u.shell;
        extraGroups = u.groups;
      }) enabledUsers;
      security.sudo.extraRules =
        lib.mapAttrsToList (name: _: {
          users = [ name ];
          commands = [{
            command = "ALL";
            options = [ "NOPASSWD" ];
          }];
        }) enabledUsers;
      programs = {
        nh = {
          enable = true;
          clean.enable = true;
          flake = "${self.outPath}";
        };
        nix-ld.enable = true;
      };
    };
  };
}
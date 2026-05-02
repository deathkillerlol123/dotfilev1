{inputs,self,...}:{
  flake.nixosModules.main-user = {lib,config,pkgs,...}:{
    options  = {
      main-user.enable = lib.mkEnableOption "enable user module";
      main-user = {
        username = lib.mkOption {
          default = "nixboom";
        };
        shell = lib.mkOption {
          default = "fish";
        };
        flakelocation = lib.mkOption {
          default = "${self.outPath}";
        };
        groups = lib.mkOption {
          default = ["wheel"];
        };	
      };
    };
    config = {
      users.users.${config.main-user.username} = {
        isNormalUser = true;
        shell = pkgs.${config.main-user.shell};
        extraGroups = config.main-user.groups;
      };
      security = {
        sudo.extraRules = [{
          users = [config.main-user.username];
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
  	  flake = "${self.outPath}";
        };
        nix-ld = {
          enable = true;
        };
      };
    };
  };
}
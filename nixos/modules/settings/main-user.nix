{inputs,...}:{
  flake.nixosModules.main-user = {lib,config,pkgs,...}:{
    options  = {
      main-user.enable = lib.mkEnableOption "enable user module";
      main-user = {
        userName = lib.mkOption {
          default = "mainuser";
        };
        shell = lib.mkOption {
          default = "fish";
        };
        flakelocation = lib.mkOption {
          default = "/etc/nixos/";
        };
        groups = lib.mkOption {
          default = ["wheel"];
        };
      };
    };
    config = lib.mkIf config.main-user.enable {
      users.users.${config.main-user.userName} = {
        isNormalUser = true;
        shell = pkgs.${config.main-user.shell};
        extraGroups = config.main-user.groups;
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
  	  flake = "/home/nixboom/dotfiles/nixos";
        };
        nix-ld = {
          enable = true;
        };
      };
   };
 };
}
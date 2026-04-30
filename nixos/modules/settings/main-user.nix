{inputs,self,...}:{
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
          default = "${self.outPath}";
        };
        groups = lib.mkOption {
          default = ["wheel"];
        };
	home-manager.enable = lib.mkEnableoption "homemanager";
        home-man = {
          ext = lib.mkOption {
            default = "backup";
          };
   	  system = lib.mkOption {
   	    default = "x86_64-linux";
   	  };
     	  username = lib.mkOption {
   	    default = "nixboom";
   	  };
   	  device = lib.mkOption {
   	    default = "dragonfly";
   	  };
   	  file = lib.mkOption {
   	    default = "_home.nix";
   	  };
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
  	  flake = "${self.outPath}";
        };
        nix-ld = {
          enable = true;
        };
     };
     home-manager = {
       useUserPackages = true;
       useGlobalPkgs = true;
       backupFileExtension = config.home-man.ext;
       extraSpecialArgs = { inherit inputs ; };
       users = {
         "${config.home-man.username}" = import "${self.outPath}/modules/hosts/${config.home-man.system}/${config.home-man.username}/${config.home-man.device}/${config.home-man.file}";
       };
      };
    };     
  };
}
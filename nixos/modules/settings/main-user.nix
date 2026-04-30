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
	home-man.enable = lib.mkEnableOption "homemanager";
        home-man = {
          ext = lib.mkOption {
            default = "backup";
          };
   	  system = lib.mkOption {
   	    default = "x86_64-linux";
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
      home-manager = {
        useUserPackages = true;
	useGlobalPkgs = true;
	backupFileExtension = config.main-user.home-man.ext;
	extraSpecialArgs = { inherit inputs ; };
	users = {
          "${config.main-user.username}" = import "${self.outPath}/modules/hosts/${config.main-user.home-man.system}/${config.main-user.username}/${config.main-user.home-man.device}/${config.main-user.home-man.file}";
        };
      };
    };
  };
}
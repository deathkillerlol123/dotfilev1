{inputs,self,...}:{
  flake.nixosModules.home-man = {lib,config,pkgs,...}:{
    options = {
      home-man.enable = lib.mkEnableOption "homemanager";
      home-man = {
        ext = lib.mkOption {
          default = "backup";
        };
   	system = lib.mkOption {
   	  default = "x86_64-linux";
   	};
   	file = lib.mkOption {
   	  default = "_home.nix";
   	};
	username = lib.mkOption {
	  default = "nixboom";
	};
      };
    };
    config = lib.mkIf config.home-man.enable {
      home-manager = {
        useUserPackages = true;
	useGlobalPkgs = true;
	backupFileExtension = config.home-man.ext;
	extraSpecialArgs = { inherit inputs ; };
	users = {
          "${config.home-man.username}" = import "${self.outPath}/modules/hosts/users/${config.home-man.username}/${config.home-man.file}";
        };
      };
    };
  };
}
{inputs,self,...}:{
  flake.nixosModules.home-man = {inputs,lib,config,pkgs,...}:{
    options = {
      home-man.enable = lib.mkEnableOption "enable home manager";
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
      };
    };
    config = lib.mkIf config.home-man.enable {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = config.home-man.ext;
        extraSpecialArgs = { inherit inputs ; };
          users = {
            config.home-man.user = import "${self.outPath}/modules/hosts/${config.home-man.system}/${config.home-man.username}/${config.home-man.device}/_home.nix";
          };
      };
    };
  };
}
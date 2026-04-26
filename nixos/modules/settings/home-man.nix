{inputs,lib,config,pkgs,...}:{
  options = {
    home-man.enable = lib.mkEnableOption "enable home manager";
    home-man = {
      ext = lib.mkOption {
        default = "backup";
      };
      home = lib.mkOption {
        default = "";
      };
    };
  };
  config = lib.mkIf config.home-man.enable {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = config.home-man.ext;
      extraSpecialArgs = { inherit inputs ; };
        users = {
          nixboom = import config.home-man.home;
        };
    };
  };
}
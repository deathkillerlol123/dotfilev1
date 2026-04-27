{inputs,self,...}:{
  flake.nixosModules.home-man = {inputs,lib,config,pkgs,...}:{
    imports= [
      inputs.home-manager.nixosModules.home-manager
    ];
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
  };
}
{self,...}:{
  flake.nixosModules.lime = {lib,config,...}:{
    options = {
      lime.enable = lib.mkEnableOption "limine";
      lime = {
        generations = lib.mkOption {
          default = 3;
        };
        wallpapers = lib.mkOption {
	  default = "${self.outPath}/bootloader";
        };
        params = lib.mkOption {
          default = [""];
        };
        windows = {
          location = lib.mkOption {
  	  default = "";
          };
        };
      };
    };
    config = lib.mkIf config.lime.enable {
     boot = {
       kernelParams = config.lime.params;     
       loader = {
         efi.canTouchEfiVariables = true;    
         limine = {
           enable = true;
     	   maxGenerations = config.lime.generations;
     	   style.wallpapers = lib.filesystem.listFilesRecursive config.lime.wallpapers;
     	   extraEntries = ''
     	     /Windows
     	       protocol: efi
     	       path: ${config.lime.windows.location}
  	    '';
         };
       };
     };
    };
  };
}

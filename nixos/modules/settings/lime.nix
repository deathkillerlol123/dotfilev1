{lib,config,pkgs,...}:{
  options = {
    lime.enable = lib.mkEnableOption "limine";
    lime = {
      generations = lib.mkOption {
        default = 3;
      };
      wallpapers = lib.mkOption {
       default = "$HOME/Pictures/Wallpapers";
      };
      params = lib.mkOption {
        default = [""];
      };
      windows.enable = lib.mkEnableOption "test";
      windows = {
        location = lib.mkOption {
	  default = "";
        };
      };
    };
  };
  config = lib.mkIf config.lime.enable {
   boot = {
     loader = {
       efi.canTouchEfiVariables = true;    
       limine = {
         enable = true;
	 maxGenerations = config.lime.generations;
	 style.wallpapers = lib.filesystem.listFilesRecursive config.lime.wallpapers;
	 extraEntries = ''
	   /Windows
	     protocol: efi
	     path: config.windows.location
	 '';
       };
     };
     kernelParams = config.lime.params;
   };
  };
}
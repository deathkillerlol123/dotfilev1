{lib,config,pkgs,...}:
{
  options = {
    lime.enable = lib.mkOption "limine";
    lime = {
      generations = lib.mkOption {
        default = 3;
      };
      wallpapers = lib.mkOption {
       default = "$HOME/Pictures/Wallpapers";
      };
    };
    windows.enable = lib.mkOption "windows";
    windows = {
      location = lib.mkOption {
        default = "";
      };
  };
  config = lib.mkIf config.lime.enable {
   boot = {
     efi.canTouchEfiVariables = true;
     loader = {
       limine = {
         enable = true;
	 maxGenerations = config.lime.generations;
	 style.wallpapers =lib.filesystem.listFilesRecursive config.lime.wallpapers;
       };
     };
   };
  };
  config = lib.mkIf config.windows.enable {
    boot.loader.limine = {
      extraEntries = ''
        /Windows
          protocol: efi
	  path: config.windows.location
      '';
    };
  };
}
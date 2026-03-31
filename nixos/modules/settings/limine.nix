{lib,config,pkgs, ...}:
{
  options = {
    lime.enable = lib.mkEnableOption "enable limine modules";
    lime = {
      generations = lib.mkOption {
        default = "3";
      };
    };
    windows.enable = lib.mkEnableoption "enable windows location";
      windows = {
        location = libmkOption {
	  default = "null"
  };
  config = lib.mkIf config.lime.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
	maxGenerations = config.lime.generations;
      };
    };
  };
  config = lib.mkIf config.windows.enable {
    boot.loader.limine.extraEnteries = ''
      /Windows
        protocol: efi
	path: config.windows.location
    '';
  };
}
{lib,config,pkgs, ...}:
{
  options = {
    cleaner.enable = lib.mkEnableOption "enable cleaner modules";
    cleaner = {
      flake-location = lib.mkOption {
        default = "/tmp";
      };
    };
  };
  config = lib.mkIf config.cleaner.enable {
    programs = {
      nh = {
        enable = true;
        clean.enable = true;
        flake = config.cleaner.flake-location;
      };
      nix-ld = {
        enable = true;
      };
    };
  };
}
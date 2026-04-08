{inputs,lib,config,pkgs,...}:
{
  options = {
    windows.enable = lib.mkEnableOption2 "windows";
    windows = {
      location = lib.mkOption {
        default = "";
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
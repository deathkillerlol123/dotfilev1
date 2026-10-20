{
  flake.nixosModules.gaming = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.gaming.xbox.enable = lib.mkEnableOption "Xbox controller support";
    config = {
      programs = {
        gamemode.enable = true;
        gamescope = {
          enable = true;
          capSysNice = false;
        };
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          gamescopeSession.enable = true;
          protontricks.enable = true;
          extest.enable = true;
        };
      };
      environment.systemPackages = with pkgs; [mangohud protonup-qt heroic];
      hardware = lib.mkIf config.gaming.xbox.enable {
        xone.enable = true;
        graphics = {
          enable = true;
          enable32Bit = true;
        };
        bluetooth = {
          enable = true;
          powerOnBoot = true;
          settings.General = {
            Privacy = "device";
            JustWorksRepairing = "always";
            Class = "0x000100";
            FastConnectable = true;
          };
        };
      };
    };
  };
}

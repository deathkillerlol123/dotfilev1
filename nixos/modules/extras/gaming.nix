{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
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
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
          vpl-gpu-rt
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.intel-media-driver
        ];
      };
      environment.systemPackages = with pkgs; [
        mangohud
        protonup-qt
        heroic
      ];
    };
}

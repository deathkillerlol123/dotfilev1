{ ... }:
{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      programs = {
        gamemode.enable = true;
        gamescope = {
          enable = true;
          capSysNice = true;
        };
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          gamescopeSession.enable = true;
          protontricks.enable = true;
          extest.enable = true;
          platfornOptimizations.enable = true;          
        };
      };
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
      environment.systemPackages = with pkgs; [
        mangohud
        protonup-qt
        heroic
        gamescope
        gamemode
      ];
    };
}

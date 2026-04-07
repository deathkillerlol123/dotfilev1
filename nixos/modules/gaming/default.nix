{pkgs, ...}:
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
    };  
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
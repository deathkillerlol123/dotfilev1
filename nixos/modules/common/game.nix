{pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    heroic
    gamescope
    gamemode  
  ];
}
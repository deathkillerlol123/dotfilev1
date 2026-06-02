{ config, pkgs, ... }:
let
  windows-session = pkgs.writeTextFile {
    name = "windows-session";
    destination = "/share/wayland-sessions/windows.desktop";
    text = ''
      [Desktop Entry]
      Name=Windows
      Comment=Reboot into Windows
      Exec=systemctl reboot --boot-loader-entry=Windows Boot Manager
      Type=Application
    '';
  };
in
{
  flake.nixosModules.bluescreen = {config,pkgs,...}:{
    services.displayManager.sessionPackages = [
      windows-session
    ];
  };
}

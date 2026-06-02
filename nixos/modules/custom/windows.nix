{ config, pkgs, ... }:{
  flake.nixosModules.bluescreen = {config,pkgs,inputs,lib,...}:{
    environment.etc."share/xsessions/windows.desktop".text = ''
      [Desktop Entry]
      Name=Windows
      Comment=Reboot into Windows
      Exec=systemctl reboot --boot-loader-entry=Windows Boot Manager
      Type=Application
    '';
  };
}
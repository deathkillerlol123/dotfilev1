{inputs,self, pkgs, ... }:
let
  bootWindows = pkgs.writeShellScriptBin "boot-windows" ''
    set -e

    BOOTNUM=$(efibootmgr | awk -F'Boot|\\*' '/Windows Boot Manager/ {print $2; exit}')

    if [ -z "$BOOTNUM" ]; then
      echo "Windows Boot Manager not found"
      exit 1
    fi

    sudo efibootmgr -n "$BOOTNUM"
    sudo reboot
  '';
in
{
  flake.nixosModules.windows = {pkgs,...}:{
    environment.systemPackages = [
      bootWindows
      pkgs.efibootmgr
    ];
    environment.etc."xsessions/windows.desktop".text = ''
      [Desktop Entry]
      Name=Windows
      Comment=Boot into Windows via EFI BootNext
      Exec=${bootWindows}/bin/boot-windows
      Type=Application
    '';
  };
}
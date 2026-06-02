{ pkgs, ... }:
let
  bootWindows = pkgs.writeShellScriptBin "boot-windows" ''
    set -euo pipefail

    # Extract Windows Boot Manager entry safely
    BOOTNUM=$(
      efibootmgr \
        | grep -i "Windows Boot Manager" \
        | head -n1 \
        | sed -E 's/^Boot([0-9A-Fa-f]+).*/\1/'
    )

    if [ -z "$BOOTNUM" ]; then
      echo "Windows Boot Manager not found"
      exit 1
    fi

    # Set next boot entry
    efibootmgr -n "$BOOTNUM"

    # Reboot via systemd (preferred on NixOS)
    systemctl reboot
  '';
in
{
  flake.nixosModules.bluescreen = {config,inputs,pkgs,...}:{
    environment.systemPackages = [
      bootWindows
    ];
  };
}
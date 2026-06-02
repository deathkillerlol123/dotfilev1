{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.efibootmgr
    (pkgs.writeShellScriptBin "reboot-windows" ''
      set -euo pipefail

      entry=$(
        efibootmgr |
        grep -i "windows" |
        head -n1 |
        sed -E 's/^Boot[0-9A-Fa-f]+\\*? //'
      )

      if [ -z "$entry" ]; then
        echo "No Windows EFI boot entry found"
        exit 1
      fi

      exec systemctl reboot --boot-loader-entry="$entry"
    '')
  ];
}
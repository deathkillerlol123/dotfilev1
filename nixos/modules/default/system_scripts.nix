{...}: {
  flake.nixosModules.system_scripts = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "reboot-windows" ''
        set -euo pipefail
        win_boot=$(
          ${pkgs.efibootmgr}/bin/efibootmgr |
            ${pkgs.gawk}/bin/awk -F'Boot|\*' \
              '/Windows Boot Manager/ {print $2; exit}'
        )
        if [[ -n "$win_boot" ]]; then
          sudo ${pkgs.efibootmgr}/bin/efibootmgr -n "$win_boot"
          sudo reboot
        else
          echo "Windows Boot Manager entry not found." >&2
          exit 1
        fi
      '')
    ];
  };
}

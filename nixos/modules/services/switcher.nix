{
  flake.nixosModules.switcher = { pkgs, ... }: {

    systemd.services.powerprofile-switch = {
      description = "Switch power profile based on AC state";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = ''
          ${pkgs.coreutils}/bin/test -f /sys/class/power_supply/AC/online

          STATE=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/AC/online 2>/dev/null || echo 0)

          ${pkgs.coreutils}/bin/test "$STATE" = "1" \
            && ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance \
            || ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
        '';
      };
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", KERNEL=="AC", \
        RUN+="${pkgs.systemd}/bin/systemctl start powerprofile-switch.service"
    '';

    systemd.services.powerprofile-switch-boot = {
      description = "Initialize power profile at boot";

      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";

        ExecStart = ''
          ${pkgs.coreutils}/bin/test -f /sys/class/power_supply/AC/online

          STATE=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/AC/online 2>/dev/null || echo 0)

          ${pkgs.coreutils}/bin/test "$STATE" = "1" \
            && ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance \
            || ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
        '';
      };
    };
  };
}

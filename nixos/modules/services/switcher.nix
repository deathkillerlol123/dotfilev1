{
  flake.nixosModules.switcher = { pkgs, ... }: {
    systemd.services.powerprofile-switch = {
      description = "Switch power profile based on AC state";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.bash}/bin/bash -c '
            STATE=$(cat /sys/class/power_supply/AC/online 2>/dev/null || echo 0)
            if [ "$STATE" = "1" ]; then
              ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
            else
              ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
            fi
          '
        '';
      };
    };
    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="*", \
        RUN+="${pkgs.systemd}/bin/systemctl start powerprofile-switch.service"
    '';
    systemd.services.powerprofile-switch-boot = {
      description = "Initialize power profile at boot";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
        '';
      };
    };
  };
}

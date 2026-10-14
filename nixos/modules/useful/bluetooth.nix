{...}: {
  flake.nixosModules.bluetooth = {pkgs, ...}: {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
          };
          Policy = {
            AutoEnable = true;
          };
        };
      };
    };
    systemd.user.services.bluetooth-autostart = {
      wantedBy = ["default.target"];
      after = ["default.target"];
    };
    systemd.user.services.mpris-proxy = {
      after = ["network.target" "sound.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
        Restart = "on-failure";
      };
    };
  };
}

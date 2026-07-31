{...}: {
  flake.nixosModules.bluetooth = {
    config,
    lib,
    ...
  }: {
    options.ble.enable = lib.mkEnableOption "bluetooth";
    config = lib.mkIf config.ble.enable {
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
    };
  };
}

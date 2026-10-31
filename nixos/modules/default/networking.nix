{...}: {
  flake.nixosModules.networking = {...}: {
    networking = {
      hostName = "nixbtw";
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
      firewall = {
        enable = true;
        allowPing = false;
      };
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
      enableIPv6 = true;
      useDHCP = true;
      wireless.enable = false;
    };
    services.resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      dnsovertls = "opportunistic";
    };
    hardware.enableRedistributableFirmware = true;
  };
}

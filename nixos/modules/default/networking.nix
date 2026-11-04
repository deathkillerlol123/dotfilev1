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
      nameservers = ["1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4"];
      enableIPv6 = true;
    };
    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = "allow-downgrade";
        DNSOverTLS = "opportunistic";
      };
    };
    hardware.enableRedistributableFirmware = true;
  };
}

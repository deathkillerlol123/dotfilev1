{ inputs, pkgs, ... }:
{
  flake.nixosModules.uxplay =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        uxplay
        avahi
      ];
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          hinfo = true;
          userServices = true;
          workstation = true;
          domain = true;
        };
      };
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          7000
          7100
          7001
        ];
        allowedUDPPorts = [
          5353
          6000
          6001
          7011
        ];
      };
    };
}

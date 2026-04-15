{config,pkgs,...}:
{
  networking = {
    firewall = {
      allowedTCPPorts = [ 7000 7001 7100 ];
      allowedUDPPorts = [ 5353 6000 6001 7011 ];
    };
  };
  services = {
    avahi = {
      enable = true;
      nssmdns = true;  # printing
      openFirewall = true; # ensuring that firewall ports are open as needed
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
        domain = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    uxplay
  ];
}

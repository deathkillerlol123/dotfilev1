{config,pkgs,...}:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui = {
      user = "nixboom";
      password = "expire";
    };
  };
  networking.firewall.allowedTCPPorts = [ 8384 ];
}
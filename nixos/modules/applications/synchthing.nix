{config,pkgs,...}:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui = {
      user = "nixboom";
      password = "expire";
      folders = {
        "First" = {
	  path = "/mnt/SteamLibrary";
	 };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 8384 ];
}
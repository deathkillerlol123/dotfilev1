{config, lib, pkgs, inputs, ...}:
{
  services = {
    blueman = {
      enable = true;
    };
    flatpak.enable = true;
    libinput.enable = true;
  };
  time.timeZone = "Europe/London"; 
  networking = {
    hostName = "nixbtw";
    networkmanager.enable = true;  };
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };  };
}

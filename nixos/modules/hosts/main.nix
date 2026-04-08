{config, lib, pkgs, inputs, ...}:
{
  imports = [
    ../settings
    ../common    
    ../environment
    ../gaming
    ../login
    ../portals
    ../sound
  ];
  documentation.enable = false;
  services = {
    blueman.enable = true;
    flatpak.enable = true;
    libinput.enable = true;
    xserver.wacom.enable = true;
    fwupd.enable = false;
  };
  programs.dconf.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;  
  time.timeZone = "Europe/London"; 
  networking = {
    hostName = "nixbtw";
    networkmanager.enable = true;  };
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };  };
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    optimise = {
      automatic = true;
      dates = ["20:00"];
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };  
  hardware = {
    uinput.enable = true;
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
}    

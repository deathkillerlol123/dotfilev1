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
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    optimise = {
      automatic = true;
      dates = ["20:00"];
    };
  };
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
}

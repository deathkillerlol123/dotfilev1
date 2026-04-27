{inputs,self,...}:{
  flake.nixosModules.main = {config, lib, pkgs, inputs, ...}:{
    imports = [
      self.nixosModules.login
      self.nixosModules.system
      self.nixosModules.environment
      self.nixosModules.software      
      self.nixosModules.gaming
      self.nixosModules.portals
      self.nixosModules.sound
      self.nixosModules.flatpak
      self.nixosModules.lime
      self.nixosModules.main-user
      self.nixosModules.home-man                  
    ];
    documentation.enable = false;
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      consoleLogLevel = 3;
      kernelParams = [
        "zswap.enabled=1"
        "zswap.compressor=lz4"
        "zswap.max_pool_percent=20"      
        "zswap.shrinker.enabled=1"
      ];
    };
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
    security = {
      pam.services.swaylock = {};
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
  };
}
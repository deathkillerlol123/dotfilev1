{inputs,self,...}:{
  flake.nixosModules.main = {config, lib, pkgs, inputs, ...}:{
    imports = with self.nixosModules; [
      login
      system
      environment
      software
      aesthetics
      gaming
      portals     
      sound
      flatpak
      lime
      home-man
    ];
    documentation.enable = false;
    boot = {
      tmp.cleanOnBoot = true;    
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
      logind.settings.Login.KillUserProcesses = true;
      libinput.enable = true;
      xserver.wacom.enable = true;
      fwupd.enable = false;
      thermald.enable = true;
      tlp = {
        enable = true;
	settings = {
          CPU_BOOST_ON_AC = 0;
          CPU_BOOST_ON_BAT = 0;
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          STOP_CHARGE_THRESH_BAT0 = 95;
	};
      };
    };
    programs = {
      dconf.enable = true;
      kdeconnect.enable = true;
    };
    systemd.services.NetworkManager-wait-online.enable = false;  
    time.timeZone = "Europe/London"; 
    networking = {
      hostName = "nixbtw";
      networkmanager.enable = true;
      nameservers = [ "1.1.1.1" "8.8.8.8" ];      
    };
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
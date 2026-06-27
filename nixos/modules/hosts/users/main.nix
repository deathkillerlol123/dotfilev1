{inputs,self,...}:{
  flake.nixosModules.main = { lib, pkgs, ...}:
    let
      enabledservices = names: lib.genAttrs names (_: { enable = true; });
    in
    {
    imports = with self.nixosModules; [
      sound bluetooth touch portals bash system
    ];
    documentation.enable = false;
    boot = {
      tmp.cleanOnBoot = true;
      consoleLogLevel = 3;
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "zswap.enabled=1"
        "zswap.compressor=lz4"
        "zswap.max_pool_percent=20"      
        "zswap.shrinker.enabled=1"
      ];
    };
    programs = enabledservices [ "dconf" "kdeconnect" ];
    services = enabledservices [ "blueman" "flatpak" "libinput" "thermald" ] //
    {
      logind.settings.Login.KillUserProcesses = true;
      fwupd.enable = false;
      xserver.wacom.enable = true;    
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
      };
    };
    nixpkgs.config = {
      allowUnfree = true;
    };
    security = {
      pam.services.swaylock = {};
    };  
  };
}

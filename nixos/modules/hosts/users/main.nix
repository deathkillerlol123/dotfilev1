{self, ...}: {
  flake.nixosModules.main = {
    lib,
    pkgs,
    inputs,
    ...
  }: let
    enabled = names:
      lib.genAttrs names (_: {
        enable = true;
      });
    df = lib.mkDefault;
    fmod = names: map (x: self.nixosModules.${x}) names;
  in {
    imports =
      fmod [
        "sound"
        "bluetooth"
        "gaming"
        "touch"
        "intel"
        "lime"
        "portals"
        "alias"
        "bash"
        "system"
        "uxplay"
      ]
      ++ [inputs.mango.nixosModules.mango];
    documentation = {
      enable = false;
      man.cache.enable = false;
    };
    virtualisation.libvirtd = {
      enable = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
    boot = {
      tmp.cleanOnBoot = true;
      consoleLogLevel = 3;
      plymouth.enable = false;
      kernelPackages = pkgs.linuxPackages_zen;
      loader.timeout = 0;
      kernelParams = ["random.trust_cpu=on"];
      kernel.sysctl = {
        "vm.swappiness" = df 150;
        "vm.watermark_boost_factor" = df 0;
        "vm.watermark_scale_factor" = df 125;
        "vm.page-cluster" = df 0;
      };
    };
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = df 100;
      memoryPercent = df 50;
    };
    programs = enabled ["dconf" "xwayland"];
    services =
      enabled ["blueman" "flatpak" "libinput" "fstrim"]
      // {
        logind.settings.Login.KillUserProcesses = true;
        fwupd.enable = false;
        xserver.wacom.enable = true;
        journald.extraConfig = "SystemMaxUse=50M";
        earlyoom = {
          enable = df true;
          freeMemThreshold = df 5;
          freeSwapThreshold = df 10;
          enableNotifications = df true;
        };
      };
    systemd = {
      services = {
        NetworkManager-wait-online.enable = false;
        nix-daemon.enable = df true;
      };
    };
    system.autoUpgrade.runGarbageCollection = true;
    hardware.enableAllFirmware = true;
    powerManagement.cpuFreqGovernor = "performance";
    time.timeZone = "Europe/London";
    networking = {
      hostName = "nixbtw";
      networkmanager.enable = true;
      firewall.enable = true;
      nameservers = ["1.1.1.1" "8.8.8.8"];
    };
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        max-jobs = "auto";
        cores = 0;
        require-sigs = true;
      };
      optimise.automatic = true;
    };
    nixpkgs.config = {
      allowUnfree = true;
    };
    security = {
      pam.services.swaylock = {};
      polkit.enable = true;
    };
  };
}

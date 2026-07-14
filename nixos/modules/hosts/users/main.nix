{ inputs, self, ... }:
{
  flake.nixosModules.main =
    { lib, pkgs, ... }:
    let
      enabled =
        names:
        lib.genAttrs names (_: {
          enable = true;
        });
      df = lib.mkDefault;
    in
    {
      imports = with self.nixosModules; [
        sound
        bluetooth
        touch
        portals
        alias
        bash
        system
      ];
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
        kernelParams = [
          "random.trust_cpu=on"
        ];
        kernel.sysctl = {
          "vm.swappiness" = df 180;
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
      programs = enabled [
        "dconf"
        "xwayland"
      ];
      services =
        enabled [
          "blueman"
          "flatpak"
          "libinput"
          "thermald"
          "fstrim"
        ]
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
      hardware.enableAllFirmware = true;
      time.timeZone = "Europe/London";
      networking = {
        hostName = "nixbtw";
        networkmanager.enable = true;
        firewall.enable = true;
        nameservers = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
      system.autoUpgrade = {
        enable = true;
        allowReboot = false;
      };
      nix = {
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        optimise = {
          automatic = true;
        };
      };
      nixpkgs.config = {
        allowUnfree = true;
      };
      security.pam.services.swaylock = { };
    };
}

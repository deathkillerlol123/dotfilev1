{ inputs, self, ... }:
{
  flake.nixosModules.main =
    { lib, pkgs, ... }:
    let
      enabledservices =
        names:
        lib.genAttrs names (_: {
          enable = true;
        });
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
      documentation.enable = false;
      virtualisation.libvirtd = {
        enable = false;
        onBoot = "ignore";
        onShutdown = "shutdown";
      };
      boot = {
        tmp.cleanOnBoot = true;
        consoleLogLevel = 3;
        kernelPackages = pkgs.linuxPackages_zen;
        loader.timeout = 10;
        kernelParams = [
          "random.trust_cpu=on"
        ];
      };
      zramSwap = {
        enable = true;
        algorithm = "zstd";
        priority = lib.mkDefault 100;
        memoryPercent = lib.mkDefault 50;
      };
      boot.kernel.sysctl = {
        "vm.swappiness" = lib.mkDefault 180;
        "vm.watermark_boost_factor" = lib.mkDefault 0;
        "vm.watermark_scale_factor" = lib.mkDefault 125;
        "vm.page-cluster" = lib.mkDefault 0;
      };
      programs = enabledservices [
        "dconf"
        "kdeconnect"
      ];
      services =
        enabledservices [
          "blueman"
          "flatpak"
          "libinput"
          "thermald"
        ]
        // {
          logind.settings.Login.KillUserProcesses = true;
          fwupd.enable = false;
          xserver.wacom.enable = true;
          journald.extraConfig = "SystemMaxUse=50M";
          tuned = {
            enable = false;
            settings.dynamic_tuning = true;
            ppdSupport = true;
            ppdSettings.main.default = "performance";
          };
        };
      systemd.services.NetworkManager-wait-online.enable = false;
      time.timeZone = "Europe/London";
      networking = {
        hostName = "nixbtw";
        networkmanager.enable = true;
        nameservers = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
      system = {
        autoUpgrade = {
          enable = true;
          allowReboot = false;
        };
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
      security = {
        pam.services.swaylock = { };
      };
    };
}

{self,inputs,...}:{
  flake.nixosModules.dragware = { config, lib, pkgs, modulesPath, ... }:{
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];
  
    boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];
  
    fileSystems."/" =
      { device = "/dev/disk/by-uuid/c43b17d9-19ec-4724-b280-b3d28a5b3483";
        fsType = "ext4";
      };
  
    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/5D22-BE76";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
  
    swapDevices =
      [ { device = "/dev/disk/by-uuid/e0c9d4b4-f7bb-478b-978a-851ed29d090c"; }
      ];
  
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

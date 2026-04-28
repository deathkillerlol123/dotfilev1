{inputs,...}:{
  flake.nixosModules.lapware = { config,lib,pkgs,modulesPath, ...}:  {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
    
      boot = {
        initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
	initrd.kernelModules = [ ];
	kernelModules = [ "kvm-intel" ];
	extraModulePackages = [ ];
      };
      fileSystems."/" =
        { device = "/dev/disk/by-uuid/cb7dccfb-5750-4c24-8ba0-e15f29458ffd";
          fsType = "ext4";
        };
    
      fileSystems."/boot" =
        { device = "/dev/disk/by-uuid/047A-4123";
          fsType = "vfat";
          options = [ "fmask=0022" "dmask=0022" ];
        };
    
      swapDevices =
        [ { device = "/dev/disk/by-uuid/4eeca876-0e97-44b6-9ca8-08f7860baf66"; }
        ];
    
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware; 
  };
}

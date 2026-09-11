{...}: {
  flake.nixosModules.intel = {pkgs, ...}: {
    hardware.graphics = {
      extraPackages = with pkgs; [intel-media-driver vpl-gpu-rt];
      extraPackages32 = with pkgs; [driversi686Linux.intel-media-driver];
    };
  };
}

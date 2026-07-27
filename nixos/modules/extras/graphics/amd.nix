{...}: {
  flake.nixosModules.amd = {pkgs, ...}: {
    hardware.graphics.extraPackages = with pkgs; [
      mesa
      libva
    ];
  };
}

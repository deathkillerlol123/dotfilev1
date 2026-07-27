{...}: {
  flake.nixosModules.intel = {pkgs, ...}: {
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };
}

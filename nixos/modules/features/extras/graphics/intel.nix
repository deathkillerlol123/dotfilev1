{...}: {
  flake.nixosModules.intel = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.intel.enable = lib.mkEnableOption "intel";
    config = lib.mkIf config.intel.enable {
      hardware.graphics.extraPackages = with pkgs; [intel-media-driver vpl-gpu-rt];
    };
  };
}

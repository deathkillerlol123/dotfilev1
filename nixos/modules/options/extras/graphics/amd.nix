{...}: {
  flake.nixosModules.amd = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.amd.enable = lib.mkEnableOption "amd";
    config = lib.mkIf config.amd.enable {
      hardware.graphics.extraPackages = with pkgs; [mesa libva];
    };
  };
}

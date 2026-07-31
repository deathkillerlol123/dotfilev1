{
  flake.nixosModules.touch = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.touch.enable = lib.mkEnableOption "touch";
    config = lib.mkIf config.touch.enable {
      environment.systemPackages = with pkgs; [libinput];
    };
  };
}

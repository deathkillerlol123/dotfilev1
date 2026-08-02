{
  flake.nixosModules.sound = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.tone.enable = lib.mkEnableOption "sound";
    config = lib.mkIf config.tone.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        extraConfig.pipewire-pulse."auto-switch" = {
          "pulse.cmd" = [
            {
              cmd = "load-module";
              args = "module-switch-on-connect";
            }
          ];
        };
      };
      environment.systemPackages = with pkgs; [
        ncpamixer
        pamixer
        pavucontrol
        wiremix
        playerctl
        alsa-utils
      ];
    };
  };
}

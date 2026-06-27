{_}:{
  flake.nixosModules.sound = {pkgs,...}: {
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
        "pulse.cmd" =[
          { cmd = "load-module"; args = "module-switch-on-connect"; }
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
      pulseaudio
      wireplumber
    ];
  };
}

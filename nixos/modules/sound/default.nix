{inputs, ...}:{
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
      easyeffects
    ];
    security.wrappers.noisetorch = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_resource+ep";
      source = "${pkgs.noisetorch}/bin/noisetorch";
    };
  };
}
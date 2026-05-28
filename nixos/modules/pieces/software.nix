{inputs,...}:{
  flake.nixosModules.software = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wdisplays
      wlr-randr
      firefox-devedition
      whatsapp-electron
      (discord.override {
        withOpenASAR = true;
      })
      copyq
      grim
      slurp
      swappy
      wl-clipboard
      wezterm
      alarm-clock-applet
      python315
      kdePackages.kdeconnect-kde
   ];
  };
}

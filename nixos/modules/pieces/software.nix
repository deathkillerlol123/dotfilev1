{inputs,...}:{
  flake.nixosModules.software = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wdisplays
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
      python312
      kdePackages.kdeconnect-kde
      #kdePackages.filelight
   ];
  };
}

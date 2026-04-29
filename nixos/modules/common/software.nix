{inputs,...}:{
  flake.nixosModules.software = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wdisplays   
      firefox-devedition
      whatsapp-electron
      discord
      copyq
      grim
      slurp
      swappy
      wl-clipboard
      wezterm
      cowsay
  #    qbittorrent qutebrowser

   ];
  };
}

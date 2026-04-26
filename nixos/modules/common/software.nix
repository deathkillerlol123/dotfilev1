{
  flake.nixosModules.software = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wdisplays   
      firefox-devedition
      qutebrowser
      whatsapp-electron
      discord
  
      copyq
      grim
      slurp
      swappy
      wl-clipboard
  #    qbittorrent
  #    ladybird    
   ];
  };
}
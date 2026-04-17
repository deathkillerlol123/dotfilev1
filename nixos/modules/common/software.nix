{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wdisplays   
    immich-cli
    firefox-devedition
    qutebrowser
#    ladybird
    whatsapp-electron
    discord

    copyq
    grim
    slurp
    swappy
    wl-clipboard
    qbittorrent

 ];
}

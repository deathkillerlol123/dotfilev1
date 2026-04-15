{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wdisplays   

    firefox-devedition
    qutebrowser
#    ladybird
    whatsapp-electron
    discord

    copyq
    uxplay
    grim
    slurp
    swappy
    wl-clipboard
    qbittorrent

 ];
}

{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wdisplays   
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

    stress-ng
 ];
}

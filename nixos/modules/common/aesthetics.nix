{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    quickshell
    eww
    swww    
    pywal
    swaynotificationcenter
    swaybg
    swaylock
    nautilus  
    rofi
    bzmenu
    pwmenu
    bemoji
    waybar
  ];
}
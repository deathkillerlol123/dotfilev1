{pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    swww    
    pywal
    swaynotificationcenter
    swaybg
    swaylock
    nautilus  
    rofi
    bzmenu
    pwmenu
  ];
}
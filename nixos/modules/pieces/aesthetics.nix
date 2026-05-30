{
  flake.nixosModules.aesthetics = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      swww    
      pywal
      swaynotificationcenter
      swaybg
      swaylock
      swayidle
      nautilus  
      rofi
      bzmenu
      pwmenu
    ];
  };
}

{
  flake.nixosModules.aesthetics = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      swww    
      pywal
      swaynotificationcenter
      swaylock
      nautilus  
      rofi
      bzmenu
      pwmenu
    ];
  };
}

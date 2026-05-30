{
  flake.nixosModules.aesthetics = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      swww    
      pywal
      swaynotificationcenter
      swaylock
      rofi
      bzmenu
      pwmenu
    ];
  };
}

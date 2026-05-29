{inputs,...}:{
  flake.nixosModules.environment = {pkgs, ... }: {
    services = {
      desktopManager = {
        cosmic.enable = false;
        plasma6.enable = true; #KDE plasma cannot be true with gnome
        gnome.enable = false;
      };
      xserver ={
       desktopManager = {
       #  budgie.enable = true; #cannot be true with gnome
         xfce.enable = false;
       };
       windowManager = {
         openbox.enable = false;
         dwm.enable = false;
         leftwm.enable = false;
         exwm.enable = false;
         };
      };
    };
    programs = {
      niri.enable = false;
      mangowc.enable = true;
      hyprland = {
        enable = false; #takes too long
        withUWSM = false;
        xwayland.enable = true;
      };
    };
  };
}

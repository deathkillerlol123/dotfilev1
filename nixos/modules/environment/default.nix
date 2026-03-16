{pkgs, ... }: {
  services = {
    desktopManager = {
      #plasma6.enable = true; #KDE plasma cannot be true with gnome
      gnome = {
        enable = true;
      };
    };
    xserver ={
     desktopManager = {
     #  budgie.enable = true; #cannot be true with gnome
     };
     windowManager = {
       openbox ={ 
         enable = false;
       };
       dwm = {
         enable = false;
       };
     };
    };
  };
  programs = {
    niri.enable = false;
    mangowc.enable = true;
    hyprland = {
      enable = false; #takes too long
      withUWSM = false;
      xwayland.enable = false;
    };
  };
}
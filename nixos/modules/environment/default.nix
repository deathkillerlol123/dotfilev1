{pkgs, ... }: {
  services = {
    desktopManager = {
      cosmic.enable = false;
      plasma6.enable = false; #KDE plasma cannot be true with gnome
      gnome = {
        enable = false;
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
    niri.enable = true;
    mangowc.enable = true;
    hyprland = {
      enable = false; #takes too long
      withUWSM = false;
      xwayland.enable = false;
    };
  };
}

{pkgs, ... }: {
  services = {
    desktopManager = {
      plasma6.enable = true;
      gnome = {
        enable = true;
      };
    };
    xserver ={
     desktopManager = {
       xfce = {
         enable = false;
         noDesktop = true;
         enableXfwm = true;
       };
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
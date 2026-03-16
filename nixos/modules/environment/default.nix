{pkgs, ... }: {
  services = {
    desktopManager = {
      gnome = {
        enable = false;
      };
    };
    xserver ={
     desktopManager = {
       budgie.enable = true;
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
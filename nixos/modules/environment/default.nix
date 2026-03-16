{pkgs, ... }: {
  services = {
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
    xserver ={ 
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
  };
}
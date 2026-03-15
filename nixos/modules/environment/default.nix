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
          enable = true;
        };
      };
    };
  };
}
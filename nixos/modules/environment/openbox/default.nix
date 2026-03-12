{pkgs, ... }: {
  services = {
    xserver ={ 
      windowManager = {
        openbox ={ 
          enable = false;
        };
      };
    };
  };
}
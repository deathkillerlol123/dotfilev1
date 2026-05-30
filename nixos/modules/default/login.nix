{inputs,self,...}:{
  flake.nixosModules.login = {pkgs, ... }: {
    services = {
      displayManager = {
        sddm = {
          enable = false;
          wayland.enable = true;
          package = pkgs.kdePackages.sddm;
          theme = "sddm-astronaut-theme";
        };
        gdm = {
          enable = false;
          wayland = true;
        };
        ly = {
          enable = true;
          settings = {
            clear_screen = true;
          };
        };
      };
      xserver = {
        enable = true;
        displayManager = {
          lightdm = {
            enable = false;
          };
        };
      };
    };
  };
}  

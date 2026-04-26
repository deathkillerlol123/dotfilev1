{inputs,...}:{
  flake.nixosModules.terminal = {pkgs, ... }: {
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
        lemurs = {
          enable = false;
          settings = {
            do_log = true;
          };
        };
        ly = {
          enable = true;
          settings = {
            clear_screen = true;
          };
        };
      };
      greetd = {
        enable = false;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
            user = "greeter";    
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

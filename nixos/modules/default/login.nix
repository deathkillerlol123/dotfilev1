{inputs,self,...}:{
  flake.nixosModules.login = {pkgs, ... }: {
    services = {
      displayManager = {
        gdm = {
          enable = false;
          wayland = true;
        };
	cosmic-greeter.enable = false;
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

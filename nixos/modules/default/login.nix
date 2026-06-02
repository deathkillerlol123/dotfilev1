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
	cosmic-greeter.enable = false;
        ly = {
          enable = true;
          settings = {
            clear_screen = true;
          };
        };
	sessionPackages = [
	  (pkgs.writeTextFile {
	    name = "windows-session";
	    destination = "/share/xsessions/windows.desktop";
	    text = ''
              [Desktop Entry]
              Name=Windows
              Comment=Boot Windows
              Exec=/home/nixboom/dotfiles/scripts/Boot-Windows10.sh
              Type=Application
	    '';
	} // {
	  providedSessions = [ "windows" ];
	  })
	];
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

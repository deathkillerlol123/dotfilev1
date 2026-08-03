{...}: {
  flake.homeModules.nbdesktop = {...}: {
    xdg.desktopEntries = {
      bluetooth = {
        name = "Bluetooth";
        exec = "bzmenu -l rofi";
        terminal = false;
        type = "Application";
        icon = "blueman";
        categories = ["Utility"];
      };
      sound = {
        name = "Sound";
        exec = "pwmenu -l rofi";
        terminal = false;
        type = "Application";
        icon = "org.pulseaudio.pavucontrol";
        categories = ["Utility"];
      };
      default = {
        name = "Start";
        exec = "sh -c \"whatsapp-electron & discord & firefox\"";
        terminal = false;
        icon = "firefox";
        categories = ["Utility"];
      };
      uxplay = {
        name = "Uxplay Toggle";
        exec = "/home/nixboom/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/uxplay-toggle.sh";
        terminal = false;
        icon = "terminal";
        categories = ["Utility"];
      };
    };
  };
}

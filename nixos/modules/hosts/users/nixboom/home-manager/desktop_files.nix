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
      default = {
        name = "Start";
        exec = "sh -c \"whatsapp-electron & discord & firefox\"";
        terminal = false;
        icon = "firefox";
        categories = ["Utility"];
      };
    };
  };
}

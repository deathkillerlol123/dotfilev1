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
      Screen = {
        name = "Screen";
        exec = "wlr-randr --output eDP-1 --mode 1920x1080 --pos 0,1080 --on";
        terminal = false;
        type = "Application";
        icon = "utilities-terminal";
        categories = ["Utility"];
      };
    };
  };
}

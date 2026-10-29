{...}: {
  flake.homeModules.nbdesktop = {pkgs, ...}: let
    screen = pkgs.writeShellScriptBin "screen-menu" ''
      output=$(wlr-randr | awk '/^[A-Za-z]+-[A-Za-z0-9-]+ "/ {print $1}' | fuzzel --dmenu --prompt "Monitor: ") || exit
      [ -z "$output" ] && exit
      action=$(printf 'On\nOff' | fuzzel --dmenu --prompt "$output: ") || exit
      [ -z "$action" ] && exit
      case "$action" in
        Off)
          wlr-randr --output "$output" --off
          ;;
        On)
          pos=$(wlr-randr | awk -v o="$output" '$1==o {f=1} f && /Position:/ {print $2; exit}')
          pos=$(printf '%s\n' "''${pos:-0,1080}" | fuzzel --dmenu --prompt "Position: ")
          [ -n "$pos" ] && wlr-randr --output "$output" --pos "$pos" --on
          ;;
      esac
    '';
  in {
    xdg.desktopEntries = {
      bluetooth = {
        name = "Bluetooth";
        exec = "bzmenu -l fuzzel";
        terminal = false;
        type = "Application";
        icon = "${./icons/bluetooth.png}";
        categories = ["Utility"];
      };
      Sound = {
        name = "Sound";
        exec = "pwmenu --launcher fuzzel";
        terminal = false;
        type = "Application";
        icon = "${./icons/sound.png}";
        categories = ["Utility"];
      };
      Screen = {
        name = "Screen";
        exec = "${screen}/bin/screen-menu";
        terminal = false;
        type = "Application";
        icon = "${./icons/screen.png}";
        categories = ["Utility"];
      };
    };
  };
}

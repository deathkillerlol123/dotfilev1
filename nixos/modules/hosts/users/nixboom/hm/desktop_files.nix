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
        exec = ''
          sh -c '
          output=$(wlr-randr | awk "/^[A-Za-z]+-[A-Za-z0-9-]+ \"/ {print \$1}" | rofi -dmenu -p "Monitor") || exit
          [ -z "$output" ] && exit
          action=$(printf "On\nOff" | rofi -dmenu -p "$output") || exit
          [ -z "$action" ] && exit
          case "$action" in
            Off) wlr-randr --output "$output" --off ;;
            On)
              pos=$(wlr-randr | awk -v o="$output" "\$1==o{f=1} f&&/Position:/{print \$2;exit}")
              pos=$(printf "%s" "''${pos:-0,0}" | rofi -dmenu -p "Position")
              [ -n "$pos" ] && wlr-randr --output "$output" --pos "$pos" --on
              ;;
          esac
        '';
        terminal = false;
        type = "Application";
        icon = "utilities-terminal";
        categories = ["Utility"];
      };
    };
  };
}

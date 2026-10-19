{...}: {
  flake.homeModules.wayland_autostart = {pkgs, ...}: {
    home.packages = [
      (pkgs.writeShellScriptBin "wayland_autostart" ''
        wl-paste --watch cliphist store &
        pgrep -x awww-daemon >/dev/null || awww-daemon &
        systemctl --user import-environment \
            WAYLAND_DISPLAY \
            XDG_CURRENT_DESKTOP \
            XDG_SESSION_TYPE \
            XDG_RUNTIME_DIR
        dbus-update-activation-environment --systemd \
            WAYLAND_DISPLAY \
            XDG_CURRENT_DESKTOP \
            XDG_SESSION_TYPE \
            XDG_RUNTIME_DIR
        systemctl --user start nixos-fake-graphical-session.target

        wlr-randr --output HDMI-A-1 --mode 1920x1080 --pos 0,0 --on
        wlr-randr --output eDP-1 --mode 1920x1080 --pos 1920,1080 --off

        img=$(find ${../home/Wallpapers} \
            -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
                | head -n1)
                [ -n "$img" ] && wal -i "$img"
        wshowkeys -a bottom -F 'Maple Mono NF 30' -s '#B5B520ff' -f  '#ecd29cff' -b '#201B1488' -l 600 -t 300 -U -S
      '')
    ];
  };
}

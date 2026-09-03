{...}: {
  flake.homeModules.wayland_autostart = {pkgs, ...}: {
    home.packages = [
      (pkgs.writeShellScriptBin "wayland_autostart" ''
        pgrep -x copyq >/dev/null || copyq &
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
        wlr-randr --output DP-1 --mode 1920x1080 --pos 1920,0 --on
        wlr-randr --output DP-2 --mode 1920x1080 --pos 1920,0 --on
        wlr-randr --output eDP-1 --mode 1920x1080 --pos 1920,1080 --off --transform flipped

        img=$(find ${../home/Wallpapers} \
            -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
                | head -n1)
                [ -n "$img" ] && wal -i "$img"
      '')
    ];
  };
}

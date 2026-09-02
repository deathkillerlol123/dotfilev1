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
        "$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/placement.sh" &
        img=$(find "$HOME/dotfiles/nixos/modules/hosts/users/nixboom/home/Wallpapers/" \
            -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
            | head -n1)
        [ -n "$img" ] && wal -i "$img"
      '')
    ];
  };
}

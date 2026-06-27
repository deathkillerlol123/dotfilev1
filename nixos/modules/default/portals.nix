{_}:
{
  flake.nixosModules.portals =
    { pkgs, ... }:
    {
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
        config.common.default = [
          "gtk"
          "wlr"
        ];
      };
      environment.systemPackages = with pkgs; [
        wlr-randr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
}

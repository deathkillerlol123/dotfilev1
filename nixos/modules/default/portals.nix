{inputs,...}:{
  flake.nixosModules.portals = {pkgs, ...}: {
    xdg.portal = {
     enable = true;
     extraPortals = with pkgs; [
       xdg-desktop-portal-gtk
       xdg-desktop-portal-wlr
       xdg-desktop-portal-kde
     ];
     wlr.enable = true;
      config = {
        kde = {
          default = ["kde" "gtk" "gnome"];
          "org.freedesktop.portal.openuri" = ["kde"];
        };
     };
    };  
  };
}

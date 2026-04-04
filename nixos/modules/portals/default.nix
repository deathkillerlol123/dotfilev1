{pkgs, ...}:
{
  xdg.portal = {
   enable = true;
   extraPortals = with pkgs; [
     xdg-desktop-portal-gtk
   ];
   wlr.enable = true;
    config = {
      kde = {
        default = ["kde" "gtk" "gnome"];
        "org.freedesktop.portal.openuri" = ["kde"];
      };
   };
  };  
}
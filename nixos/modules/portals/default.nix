{pkgs, ...}:
{
  xdg.portal = {
   enable = true;
   wlr.enable = true;
    config = {
      kde = {
        default = ["kde" "gtk" "gnome"];
        "org.freedesktop.portal.openuri" = ["kde"];
      };
   };
  };  
}
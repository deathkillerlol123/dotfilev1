{inputs,...}:{
  flake.nixosModules.environment = {pkgs, ... }: {
    services = {
      desktopManager = {
        cosmic.enable = false;
        plasma6.enable = false;
        gnome.enable = false;
      };
      xserver ={
       desktopManager = {
       #  budgie.enable = true;
         xfce.enable = false;
       };
       windowManager = {
         openbox.enable = false;
         dwm.enable = false;
         leftwm.enable = false;
         exwm.enable = false;
         };
      };
    };
    programs = {
      niri.enable = false;
      mangowc.enable = true;
      hyprland = {
        enable = false;
        withUWSM = false;
        xwayland.enable = true;
	package = inputs.hyprland.packages.${pkgs.system}.hyprland;
	portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };
    };
  };
}

{inputs, ...}: {
  flake.nixosModules.hyprland = {pkgs, ...}: {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = false;
        xwayland.enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };
    };
  };
}

{...}: {
  flake.homeModules.nbgtk = {
    config,
    pkgs,
    ...
  }: {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk4.theme = config.gtk.theme;
    };
  };
}

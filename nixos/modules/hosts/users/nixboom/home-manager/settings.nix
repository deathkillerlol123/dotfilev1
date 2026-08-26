{
  self,
  lib,
  ...
}: {
  flake.homeModules.settings = {
    config,
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
    home = {
      packages = with pkgs; [
        ghostty
        whatsapp-electron
        pywal
        awww
        waypaper
        rofi
        bzmenu
        copyq
        grim
        slurp
        swappy
        wl-clipboard
      ];
    };
    services.flatpak = {
      update.onActivation = true;
      packages = ["org.vinegarhq.Sober"];
    };
    programs = {
      home-manager.enable = true;
      nix-search-tv.enableTelevisionIntegration = true;
      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
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

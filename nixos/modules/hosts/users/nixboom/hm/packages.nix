{...}: {
  flake.homeModules.packages = {
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
        wl-clipboard
        grim
        slurp
        swappy
        gnome-boxes
      ];
    };
    services.flatpak = {
      update.onActivation = true;
      packages = ["org.vinegarhq.Sober"];
    };
  };
}

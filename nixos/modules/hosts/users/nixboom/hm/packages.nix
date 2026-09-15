{...}: {
  flake.homeModules.nbpackages = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
    home = {
      packages = with pkgs; [
        ghostty
        whatsie
        concord-tui
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
      ];
    };
    services.flatpak = {
      update.onActivation = true;
      packages = ["org.vinegarhq.Sober" "org.kde.drawy"];
    };
  };
}

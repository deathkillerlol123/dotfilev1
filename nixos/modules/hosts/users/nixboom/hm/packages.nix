{...}: {
  flake.homeModules.nbpackages = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
    home = {
      packages = with pkgs; [
        cwal
        awww
        fuzzel
        bzmenu
        pwmenu
        cliphist
        wl-clipboard
        grim
        slurp
        swappy
        #gthumb
      ];
    };
    services.flatpak = {
      update.onActivation = true;
      packages = [
        "org.vinegarhq.Sober"
        #"org.kde.drawy"
      ];
    };
  };
}

{...}: {
  flake.homeModules.packages = {
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
  };
}

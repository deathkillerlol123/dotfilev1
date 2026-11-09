{...}: {
  flake.homeModules.nbpackages = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
    home = {
      packages = with pkgs; [
        (concord-tui.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkg-config];
          buildInputs = (old.buildInputs or []) ++ [zstd];
        }))
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
      packages = ["org.vinegarhq.Sober" "org.kde.drawy"];
    };
  };
}

{
  self,
  lib,
  ...
}: {
  flake.homeModules.nixboom = {
    config,
    inputs,
    pkgs,
    ...
  }: let
    user = "nixboom";
    dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/modules/hosts/users/${user}/home";
    conf = "${dotfiles}/.config";
    mkFile = names:
      lib.genAttrs names (name: {
        source = "${dotfiles}/${name}";
      });
    mkconf = names:
      lib.listToAttrs (
        map (name: {
          name = ".config/${name}";
          value = {
            source = "${conf}/${name}";
            recursive = true;
            force = true;
          };
        })
        names
      );
  in {
    imports =
      [
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ]
      ++ (with self.homeModules; [nbgit nbdesktop nbfirefox nbdiscord nbstarship nbfish nbnu]);
    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "25.11";
      packages = with pkgs; [ghostty whatsapp-electron pywal awww waypaper rofi bzmenu pwmenu copyq grim slurp swappy wl-clipboard];
      file =
        (mkconf ["mango" "swaylock" "rofi" "ghostty"])
        // (mkFile [".emacs"]);
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

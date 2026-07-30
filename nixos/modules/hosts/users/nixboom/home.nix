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
    imports = [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
      self.homeModules.nbgit
      self.homeModules.nbfirefox
      self.homeModules.nbdiscord
      self.homeModules.nbstarship
    ];
    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "25.11";
      packages = with pkgs; [ghostty whatsapp-electron pywal awww waypaper rofi bzmenu pwmenu copyq grim slurp swappy wl-clipboard];
      file =
        {
          ".local/share/applications" = {
            source = "${dotfiles}/.local/share/applications";
            recursive = true;
          };
        }
        // (mkconf ["mango" "swaylock" "fastfetch" "swaync" "rofi" "ghostty"])
        // (mkFile [".emacs"]);
    };
    services.flatpak = {
      update.onActivation = true;
      packages = ["org.vinegarhq.Sober"];
    };
    programs = {
      home-manager.enable = true;
      fish = {
        enable = true;
        interactiveShellInit = ''
          set -U fish_greeting
          starship init fish | source
          zoxide init fish | source
          cd ~/dotfiles/nixos
        '';
      };
    };
    gtk = {
      enable = true;
      theme = {
        name = "Tokyonight-Dark";
        package = pkgs.tokyonight-gtk-theme;
      };
      gtk4.theme = config.gtk.theme;
    };
  };
}

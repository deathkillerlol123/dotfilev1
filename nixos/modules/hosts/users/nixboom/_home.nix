{ config, pkgs, lib, inputs, ... }:
let
  user = "nixboom";
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/dots/${user}/";
  firefox_user = "hcq4c6te.dev-edition-default";
  conf = "${dotfiles}/.config";
  mkFile = names:
    lib.genAttrs names (name: {
      source = "${dotfiles}/${name}";
    });
  mkconf = names:
    lib.listToAttrs (map (name: {
      name = ".config/${name}";
      value = {
        source = "${conf}/${name}";
        recursive = true;
      };
    }) names);
  mkdirs = paths:
    lib.genAttrs paths (path: {
      source = "${dotfiles}/${path}";
      recursive = true;
    });
in
{
  imports = [
    flake-inputs.flatpaks.homeManagerModules.nix-flatpak
  ];
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;
  home.file =
    {
      ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = { source = "${dotfiles}/.config/mozilla/userChrome.css"; };
    }
    // (mkconf ["mango" "swaylock" "fastfetch" "fish" "waybar" "walrus" "wallust" "swaync"
                "rofi" "nvim" "niri" "mako" "eww" "quickshell" "qutebrowser"
    ])
    // (mkFile [".emacs" ".wezterm.lua" ".config/starship.toml"
    ])
    // (mkdirs [
      ".local/share/applications"
    ]);
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
  };
}
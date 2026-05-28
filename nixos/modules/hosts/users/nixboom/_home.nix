{ config, pkgs, lib, inputs, ... }:

let
  dotfiles =
    config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";
  user = "nixboom";
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

in {
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  home.file =
    {
      ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = {
        source = "${dotfiles}/.config/mozilla/userChrome.css";
      };
    }
    // (mkconf [
      "mango"
      "swaylock"
      "fastfetch"
      "fish"
      "waybar"
      "walrus"
      "wallust"
      "swaync"
      "rofi"
      "nvim"
      "niri"
      "mako"
      "eww"
      "quickshell"
      "qutebrowser"
    ])
    // (mkFile [
      ".zshrc"
      ".emacs"
      ".wezterm.lua"
      ".config/starship.toml"
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
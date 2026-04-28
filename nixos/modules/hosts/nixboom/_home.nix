{ config, pkgs, ... }:

let
  dotfiles = "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";
  user = "nixboom";

  files = [
    ".zshrc"
    ".wezterm.lua"
    ".config/starship.toml"
    ".config/fastfetch"
    ".config/mango"
    ".config/swaylock"
    ".emacs"
  ];

  dirs = [
    ".config/fish"
    ".config/waybar"
    ".config/walrus"
    ".config/wallust"
    ".config/swaync"
    ".config/rofi"
    ".config/nvim"
    ".config/niri"
    ".config/mako"
    ".config/eww"
    ".config/quickshell"
    ".local/share/applications"
    ".config/qutebrowser"
  ];

  mkFile = path: {
    name = path;
    value = {
      source = "${dotfiles}/${path}";
      force = true;
    };
  };

  mkDir = path: {
    name = path;
    value = {
      source = "${dotfiles}/${path}";
      recursive = true;
      force = true;
    };
  };

in {
  home.file =
    builtins.listToAttrs (
      map mkFile files ++ map mkDir dirs
    )
    // {
      ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = {
        source = "${dotfiles}/.config/mozilla/userChrome.css";
        force = true;
      };
    };
    home = {
      username = user;
      homeDirectory = "/home/${user}";
      packages = with pkgs; [ ];
      sessionVariables = {
        EDITOR = "nvim";
      };
      stateVersion = "25.11"; # Please read the comment before changing.
    };
    programs.home-manager.enable = true;    
}
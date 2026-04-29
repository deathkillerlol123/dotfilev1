{config, pkgs,inputs, ... }:
let
  dotfiles =  config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";
  user = "nixboom";
  conf ="${dotfiles}/.config";
  mkFile = name: {
    name = name;
    value = {
      source = "${dotfiles}/${name}";
      recursive = true;
    };
  };    
  mkconf = name: {
    name = ".config/${name}";
    value = {
      source = "${conf}/${name}";
      recursive = true;
    };
  };
  configs = builtins.listToAttrs [
    (mkconf "mango")
    (mkconf "swaylock")
    (mkconf "fastfetch")
    (mkconf "starship.toml")
    (mkconf "fish")
    (mkconf "waybar")
    (mkconf "walrus")
    (mkconf "wallust")
    (mkconf "swaync")
    (mkconf "rofi")
    (mkconf "nvim")
    (mkconf "niri")
    (mkconf "mako")
    (mkconf "eww")
    (mkconf "quickshell")
    (mkconf "qutebrowser")
    (mkFile ".zshrc")
    (mkFile ".emacs")
    (mkFile ".wezterm.lua")
  ];
in
{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    packages = with pkgs; [ ];    
    stateVersion = "25.11"; # Please read the comment before changing.    
  };
  programs.home-manager.enable = true;  
  home.file = {
    ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = {
      source = "${dotfiles}/.config/mozilla/userChrome.css";
    };
    ".local/share/applications" = mkFile "${dotfiles}/.local/share/applications";     
  } // configs;
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
  };
}

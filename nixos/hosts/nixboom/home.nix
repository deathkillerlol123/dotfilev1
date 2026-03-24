{ config, pkgs,inputs, ... }:

let
  dotfiles =  config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";

in
{
  home.username = "nixboom";
  home.homeDirectory = "/home/nixboom";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
  # You should not change this value, even if you update Home Manager. If you do
  home.stateVersion = "25.11"; # Please read the comment before changing.
  home.packages = with pkgs; [ ];
  home.file = {
    ".zshrc" = {
      source = "${dotfiles}/.zshrc";
      recursive = true;
    };
    ".wezterm.lua" = {
      source = "${dotfiles}/.wezterm.lua";
      recursive = true;
    };    
    ".config/fish" = {
      source = "${dotfiles}/.config/fish";
      recursive = true;
    };    
    ".config/zellij" = {
      source = "${dotfiles}/.config/zellij";
      recursive = true;
    };
    ".config/wlogout" = {
      source = "${dotfiles}/.config/wlogout";
      recursive = true;
    };
    ".config/wayscriber" = {
      source = "${dotfiles}/.config/wayscriber";
      recursive = true;
    };
    ".config/waybar" = {
      source = "${dotfiles}/.config/waybar";
      recursive = true;
    };
    ".config/waypaper" = {
      source = "${dotfiles}/.config/waypaper";
      recursive = true;
    };
    ".config/walrus" = {
      source = "${dotfiles}/.config/walrus";
      recursive = true;
    };
    ".config/wallust" = {
      source = "${dotfiles}/.config/wallust";
      recursive = true;
    };
    ".config/swaync" = {
      source = "${dotfiles}/.config/swaync";
      recursive = true;
    };
    ".config/swaylock" = {
      source = "${dotfiles}/.config/swaylock";
      recursive = true;
    };
    ".config/spicetify" = {
      source = "${dotfiles}/.config/spicetify";
      recursive = true;
    };
    ".config/rofi" = {
      source = "${dotfiles}/.config/rofi";
      recursive = true;
    };
    ".config/ranger" = {
      source = "${dotfiles}/.config/ranger";
      recursive = true;
    };
    ".config/polybar" = {
      source = "${dotfiles}/.config/polybar";
      recursive = true;
    };
    ".config/nvim" = {
      source = "${dotfiles}/.config/nvim";
      recursive = true;
    };
    ".config/zed" = {
      source = "${dotfiles}/.config/zed";
      recursive = true;
    };
    ".config/niri" = {
      source = "${dotfiles}/.config/niri";
      recursive = true;
    };
    ".config/neofetch" = {
      source = "${dotfiles}/.config/neofetch";
      recursive = true;
    };
    ".config/mc" = {
      source = "${dotfiles}/.config/mc";
      recursive = true;
    };
    ".config/mango" = {
      source = "${dotfiles}/.config/mango";
      recursive = true;
    };
    ".config/mako" = {
      source = "${dotfiles}/.config/mako";
      recursive = true;
    };
    ".config/kitty" = {
      source = "${dotfiles}/.config/kitty";
      recursive = true;
    };
    ".config/hypr" = {
      source = "${dotfiles}/.config/hypr";
      recursive = true;
    };
    ".config/fuzzel" = {
      source = "${dotfiles}/.config/fuzzel";
      recursive = true;
    };
    ".config/fastfetch" = {
      source = "${dotfiles}/.config/fastfetch";
      recursive = true;
    };
    ".config/eww" = {
      source = "${dotfiles}/.config/eww";
      recursive = true;
    };
    ".config/quickshell" = {
      source = "${dotfiles}/.config/quickshell";
      recursive = true;
    };  
    ".config/dunst" = {
      source = "${dotfiles}/.config/dunst";
      recursive = true;
    };
    ".config/starship.toml" = {
      source = "${dotfiles}/.config/starship.toml";
      recursive = true;
    };
    ".local/share/applications" = {
      source = "${dotfiles}/.local/share/applications";
      recursive = true;
    };
    ".config/qutebrowser" = {
      source = "${dotfiles}/.config/qutebrowser";
      recursive = true;
    };
    ".config/ironbar" = {
      source = "${dotfiles}/.config/ironbar";
      recursive = true;
    };
    ".config/matugen" = {
      source = "${dotfiles}/.config/matugen";
      recursive = true;
    };    
    ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = {
      source = "${dotfiles}/.config/mozilla/userChrome.css";
      recursive = true;
    };
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
    cursorTheme = {
      size = 30;
      name = "Adwaita";
    };
  };
}

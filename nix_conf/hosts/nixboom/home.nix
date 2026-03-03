{ config, pkgs,inputs, ... }:

{
  home.username = "nixboom";
  home.homeDirectory = "/home/nixboom";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
  home.packages = with pkgs; [ ];
  home.file = {
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.zshrc";
      recursive = true;
    };
    ".config/zellij" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/zellij";
      recursive = true;
    };
    ".config/wlogout" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/wlogout";
      recursive = true;
    };
    ".config/wayscriber" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/wayscriber";
      recursive = true;
    };
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/waybar";
      recursive = true;
    };
    ".config/waypaper" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/waypaper";
      recursive = true;
    };
    ".config/walrus" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/walrus";
      recursive = true;
    };
    ".config/wallust" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/wallust";
      recursive = true;
    };
    ".config/swaync" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/swaync";
      recursive = true;
    };
    ".config/swaylock" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/swaylock";
      recursive = true;
    };
    ".config/spicetify" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/spicetify";
      recursive = true;
    };
    ".config/rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/rofi";
      recursive = true;
    };
    ".config/ranger" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/ranger";
      recursive = true;
    };
    ".config/polybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/polybar";
      recursive = true;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/nvim";
      recursive = true;
    };
    ".config/niri" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/niri";
      recursive = true;
    };
    ".config/neofetch" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/neofetch";
      recursive = true;
    };
    ".config/mc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/mc";
      recursive = true;
    };
    ".config/mango" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/mango";
      recursive = true;
    };
    ".config/mako" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/mako";
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/kitty";
      recursive = true;
    };
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/hypr";
      recursive = true;
    };
    ".config/fuzzel" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/fuzzel";
      recursive = true;
    };
    ".config/fastfetch" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/fastfetch";
      recursive = true;
    };
    ".config/eww" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/eww";
      recursive = true;
    };
    ".config/dunst" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/dunst";
      recursive = true;
    };
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/starship.toml";
      recursive = true;
    };
    ".config/mozilla/firefox/tb14nia8.dev-edition-default/chrome/userChrome.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles/.config/mozilla/firefox/tb14nia8.dev-edition-default/chrome/userChrome.css";
      recursive = true;
    };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

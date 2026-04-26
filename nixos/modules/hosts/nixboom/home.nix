{config, pkgs,inputs, ... }:
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
a  programs.home-manager.enable = true;
  # You should not change this value, even if you update Home Manager. If you do
  home.stateVersion = "25.11"; # Please read the comment before changing.
  home.packages = with pkgs; [ ];
  
  home.file = {
    ".zshrc" = {
      source = "${dotfiles}/.zshrc";
    };
    ".wezterm.lua" = {
      source = "${dotfiles}/.wezterm.lua";
    };    
    ".config/fish" = {
      source = "${dotfiles}/.config/fish";
      recursive = true;
    };    
    ".config/waybar" = {
      source = "${dotfiles}/.config/waybar";
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
    };
    ".config/rofi" = {
      source = "${dotfiles}/.config/rofi";
      recursive = true;
    };
    ".config/nvim" = {
      source = "${dotfiles}/.config/nvim";
      recursive = true;
    };
    ".config/niri" = {
      source = "${dotfiles}/.config/niri";
      recursive = true;
    };
    ".config/fastfetch" = {
      source = "${dotfiles}/.config/fastfetch";
    };
    ".config/mango" = {
      source = "${dotfiles}/.config/mango";
    };
    ".config/mako" = {
      source = "${dotfiles}/.config/mako";
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
    ".config/starship.toml" = {
      source = "${dotfiles}/.config/starship.toml";
    };
    ".local/share/applications" = {
      source = "${dotfiles}/.local/share/applications";
      recursive = true;
    };
    ".config/qutebrowser" = {
      source = "${dotfiles}/.config/qutebrowser";
      recursive = true;
    };
    ".emacs" = {
        source = "${dotfiles}/.emacs";
    };
    ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = {
      source = "${dotfiles}/.config/mozilla/userChrome.css";
    };
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
#    cursorTheme = {
 #     package = pkgs.lyra-cursors;
  #    name = "LyraB Cursors";
   #   size = 16;
   #};
  };
}

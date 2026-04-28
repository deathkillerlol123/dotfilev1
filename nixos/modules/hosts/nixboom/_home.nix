{config, pkgs,inputs, ... }:
let
  dotfiles =  config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";
  user = "nixboom";
  conf ="${dotfiles}/.config";
  mkFile = src: { source = src; recursive = true };
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
    ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = mkFile "${dotfiles}/.config/mozilla/userChrome.css";      
    ".zshrc" = mkFile "${dotfiles}/.zshrc";
    ".emacs" = mkFile "${dotfiles}/.emacs";  
    ".wezterm.lua" = mkFile "${dotfiles}/.wezterm.lua";
    ".config/mango" = mkFile "${conf}/mango";
    ".config/swaylock" = mkFile "${conf}/swaylock";
    ".config/fastfetch" = mkFile "${conf}/fastfetch";
    ".config/starship.toml" = mkFile "${dotfiles}/.config/starship.toml";
    ".config/fish" = mkFile "${conf}/fish";  
    ".config/waybar" = mkFile "${conf}/waybar";
    ".config/walrus" = mkFile "${conf}/walrus";
    ".config/wallust" = mkFile "${conf}/wallust";
    ".config/swaync" = mkFile "${conf}/swaync";
    ".config/rofi" = mkFile "${conf}/rofi";
    ".config/nvim" = mkFile "${conf}/nvim";
    ".config/niri" = mkFile "${conf}/niri";
    ".config/mako" = mkFile "${conf}/mako";
    ".config/eww" = mkFile "${conf}/eww"; 
    ".config/quickshell" = mkFile "${conf}/quickshell"; 
    ".config/qutebrowser" = mkFile "${conf}/qutebrowser"; 
    ".local/share/applications" = mkFile "${dotfiles}/.local/share/applications"; 
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
  };
}

{config, pkgs,inputs, ... }:
let
  dotfiles =  config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";
  user = "nixboom";
  conf ="${dotfiles}/.config";
  mkFile = src: { source = src; recursive = true;};
  mkconf = src: { source = "${dotfiles}/${src}"; recursive = true;};
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
    ".local/share/applications" = mkFile "${dotfiles}/.local/share/applications";     
    ".zshrc" = mkFile "${dotfiles}/.zshrc";
    ".emacs" = mkFile "${dotfiles}/.emacs";  
    ".wezterm.lua" = mkFile "${dotfiles}/.wezterm.lua";
    ".config/mango" = mkconf "mango";
    ".config/swaylock" = mkconf "swaylock";
    ".config/fastfetch" = mkconf "fastfetch";
    ".config/starship.toml" = mkconf "starship.toml";
    ".config/fish" = mkconf "fish";  
    ".config/waybar" = mkconf "waybar";
    ".config/walrus" = mkconf "walrus";
    ".config/wallust" = mkconf "wallust";
    ".config/swaync" = mkconf "swaync";
    ".config/rofi" = mkconf "rofi";
    ".config/nvim" = mkconf "nvim";
    ".config/niri" = mkconf "niri";
    ".config/mako" = mkconf "mako";
    ".config/eww" = mkconf "eww"; 
    ".config/quickshell" = mkconf "quickshell"; 
    ".config/qutebrowser" = mkconf "qutebrowser"; 

  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
  };
}

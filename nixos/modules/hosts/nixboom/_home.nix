{config, pkgs,inputs, ... }:
let
  dotfiles =  config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";
  user = "nixboom";
  conf ="${dotfiles}/.config";
in
{
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
  home.file = {
    ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = {source = "${dotfiles}/.config/mozilla/userChrome.css";};      
    ".zshrc" = {source = "${dotfiles}/.zshrc";};
    ".emacs" = {source = "${dotfiles}/.emacs";};    
    ".wezterm.lua" = {source = "${dotfiles}/.wezterm.lua";};
    ".config/mango" = {source = "${conf}/mango";};    
    ".config/swaylock" = {source = "${conf}/swaylock";};
    ".config/fastfetch" = {source = "${conf}/fastfetch";};
    ".config/starship.toml" = {source = "${dotfiles}/.config/starship.toml";};
    ".config/fish" = {source = "${conf}/fish"; recursive = true;};    
    ".config/waybar" = {source = "${conf}/waybar"; recursive = true;};
    ".config/walrus" = {source = "${conf}/walrus"; recursive = true;};
    ".config/wallust" = {source = "${conf}/wallust"; recursive = true;};
    ".config/swaync" = {source = "${conf}/swaync"; recursive = true;};
    ".config/rofi" = {source = "${conf}/rofi"; recursive = true;};
    ".config/nvim" = {source = "${conf}/nvim"; recursive = true;};
    ".config/niri" = {source = "${conf}/niri"; recursive = true;};
    ".config/mako" = {source = "${conf}/mako"; recursive = true;};
    ".config/eww" = {source = "${conf}/eww"; recursive = true;};
    ".config/quickshell" = {source = "${conf}/quickshell"; recursive = true;};
    ".config/qutebrowser" = {source = "${conf}/qutebrowser"; recursive = true;};    
    ".local/share/applications" = {source = "${dotfiles}/.local/share/applications"; recursive = true;};
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
  };
}

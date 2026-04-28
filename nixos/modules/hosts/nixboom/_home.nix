{ config, pkgs, inputs, ... }:
let
  user = "nixboom";
  firefox_user = "hcq4c6te.dev-edition-default";
  
  # Directories (recursive = true)
  dirs = [
    ".config/fish" ".config/waybar" ".config/walrus" ".config/wallust"
    ".config/swaync" ".config/rofi" ".config/nvim" ".config/niri"
    ".config/mako" ".config/eww" ".config/quickshell" ".local/share/applications"
    ".config/qutebrowser"
  ];
  
  # Single files (recursive = false)
  files = [
    ".zshrc" ".wezterm.lua" ".config/swaylock" ".config/fastfetch"
    ".config/mango" ".config/starship.toml" ".emacs"
  ];
in
{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    packages = with pkgs; [ ];    
    sessionVariables = { EDITOR = "nvim"; };    
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;
  
  # Define dotfiles path where config IS available
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles";
  src = path: "${dotfiles}/${path}";
  
  # Generate file entries
  mkFile = path: { source = src path; };
  mkDir = path: { source = src path; recursive = true; };
  
  recursiveFiles = builtins.listToAttrs (map (p: { name = p; value = mkDir p; }) dirs);
  singleFiles = builtins.listToAttrs (map (p: { name = p; value = mkFile p; }) files);
  
  # Special case for Firefox
  firefoxEntry = {
    ".config/mozilla/firefox/${firefox_user}/chrome/userChrome.css" = {
      source = src ".config/mozilla/userChrome.css";
    };
  };
  
  home.file = recursiveFiles // singleFiles // firefoxEntry;
  
  gtk = {
    enable = true;
    theme = { package = pkgs.orchis-theme; name = "Orchis-Grey-Dark"; };
  };
}

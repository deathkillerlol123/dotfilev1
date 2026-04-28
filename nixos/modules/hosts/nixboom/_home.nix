{config, pkgs, inputs, ...}:
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  user = "nixboom";
  cfg = "${dotfiles}/.config";
  
  # Helper to create file entries
  mkFile = src: { source = src; };
  mkFileRec = src: { source = src; recursive = true; };
  
  # Non-recursive files
  files = {
    ".zshrc" = mkFile "${dotfiles}/.zshrc";
    ".emacs" = mkFile "${dotfiles}/.emacs";
    ".wezterm.lua" = mkFile "${dotfiles}/.wezterm.lua";
    ".config/mozilla/firefox/hcq4c6te.dev-edition-default/chrome/userChrome.css" = 
      mkFile "${dotfiles}/.config/mozilla/userChrome.css";
  };
  
  # Recursive config directories
  configDirs = [
    "fish" "waybar" "walrus" "wallust" "swaync" "rofi" "nvim"
    "niri" "mako" "eww" "quickshell" "qutebrowser"
  ];
  
  # Generate .config/* entries
  configFiles = builtins.listToAttrs (map (dir: {
    name = ".config/${dir}";
    value = mkFileRec "${cfg}/${dir}";
  }) configDirs);
  
  # Single-file configs in .config
  singleConfigFiles = {
    "mango" = mkFile "${cfg}/mango";
    "swaylock" = mkFile "${cfg}/swaylock";
    "fastfetch" = mkFile "${cfg}/fastfetch";
    "starship.toml" = mkFile "${cfg}/starship.toml";
  };
  
  # Merge all file configurations
  allFiles = files // configFiles // singleConfigFiles // {
    ".local/share/applications" = mkFileRec "${dotfiles}/.local/share/applications";
  };
in
{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };
  
  programs.home-manager.enable = true;
  home.file = allFiles;
  
  gtk = {
    enable = true;
    theme.package = pkgs.orchis-theme;
    theme.name = "Orchis-Grey-Dark";
  };
}
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";
  user = "nixboom";
  
  src = path: "${dotfiles}/${path}";
  
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
  
  allFiles = recursiveFiles // singleFiles // firefoxEntry;
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
  home.file = allFiles;
  gtk = {
    enable = true;
    theme = { package = pkgs.orchis-theme; name = "Orchis-Grey-Dark"; };
  };
}
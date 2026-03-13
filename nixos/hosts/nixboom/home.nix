{ config, pkgs,inputs, ... }:

let
  dotfiles =  config.lib.file.mkOutOfStoreSymlink "/home/nixboom/dotfiles";
  firefox_user = "hcq4c6te.dev-edition-default";

in
{
  import = [
    ./home_files.nix
  ];
  home.username = "nixboom";
  home.homeDirectory = "/home/nixboom";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
  
  home.packages = with pkgs; [ ];
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Grey-Dark";
    };
  };
}

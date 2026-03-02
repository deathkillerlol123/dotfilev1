{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/mango.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/neofetch.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/swaync.nix
    ../../modules/home-manager/zellij.nix
    ../../modules/home-manager/zshrc.nix

  ];
  home.username = "nixboom";
  home.homeDirectory = "/home/nixboom";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
  home.packages = with pkgs; [ ];
  home.file = {  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nixboom/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.home-manager.enable = true;
}

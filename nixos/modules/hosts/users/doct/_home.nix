{config,pkgs,lib,inputs,...}:
let
  user = "doct";
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/dots/${user}/";
  conf = "${dotfiles}/.config";
in
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    update.onActivation = true;
    packages = [
      "ch.openboard.OpenBoard" "org.vinegarhq.Sober"
    ];
  };
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;
}
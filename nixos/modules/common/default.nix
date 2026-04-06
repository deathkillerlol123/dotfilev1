{config,lib,pkgs,inputs, ...}:
{
  imports = [
    ./software.nix
    ./flatpak.nix
    ./fonts.nix
  ];
}
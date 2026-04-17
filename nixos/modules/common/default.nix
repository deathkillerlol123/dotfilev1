{config,lib,pkgs,inputs, ...}:
{
  imports = [
    ./software.nix
    ./flatpak.nix
    ./fonts.nix
    ./aesthetics.nix
    ./system.nix
    ./terminal.nix
  ];
}
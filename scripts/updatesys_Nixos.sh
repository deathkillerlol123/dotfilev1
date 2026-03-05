#!/usr/bin/env zsh

sudo nix-collect-garbage -d
home-manager expire-generations -d
nix store gc
sudo nix store optimise
home-manager remove-generations old

nh clean all

sudo nixos-rebuild switch --upgrade --flake ~/dotfiles/nixos
~/dotfiles/scripts/git_updater.sh


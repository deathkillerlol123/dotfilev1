#!/usr/bin/env zsh

sudo nixos-rebuild switch --upgrade --flake ~/dotfiles/nixos
~/dotfiles/scripts/git_updater.sh

home-manager expire-generations -d
nix store gc
sudo nix store optimise
home-manager remove-generations old

nh clean all

rm -rf ~/.cache/*
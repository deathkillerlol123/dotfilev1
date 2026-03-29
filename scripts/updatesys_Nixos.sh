#!/usr/bin/env fish

sudo nixos-rebuild switch --upgrade --flake ~/dotfiles/nixos
~/dotfiles/scripts/git_updater.sh

nix store gc
sudo nix store optimise


nh clean all --keep 3

rm -rf ~/.cache/*

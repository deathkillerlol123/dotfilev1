#!/usr/bin/env fish

~/dotfiles/scripts/git_updater.sh
sudo nixos-rebuild switch --upgrade --flake ~/dotfiles/nixos
nix store gc
sudo nix store optimise
nh clean all --keep 3
rm -rf ~/.cache/*
~/dotfiles/scripts/git_updater.sh

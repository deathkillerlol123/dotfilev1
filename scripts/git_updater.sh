#!/usr/bin/env bash

cd ~/dotfiles/

sudo cp /etc/nixos/configuration.nix ~/dotfiles/nix_conf/
sudo cp /etc/nixos/flake.nix ~/dotfiles/nix_conf/
sudo cp /etc/nixos/home.nix ~/dotfiles/nix_conf/
sudo cp -r /etc/nixos/dots ~/dotfiles/nix_conf/

if [ ! -d ".git" ]; then
  git init
fi

git add .
git commit -m "Update repository with latest changes"
git push -u origin main

echo "Repository updated successfully!"

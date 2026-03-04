#!/usr/bin/env bash

cd ~/dotfiles/

#sudo cp -r /etc/nixos/* ~/dotfiles/nix_conf/

if [ ! -d ".git" ]; then
  git init
fi

git add .
git commit -m "Update repository with latest changes"
git push -u origin main

echo "Repository updated successfully!"

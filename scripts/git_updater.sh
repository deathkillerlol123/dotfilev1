#!/usr/bin/env bash
cd ~/dotfiles || exit 1
git add .
git commit -m "Update"
git push origin main

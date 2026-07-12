#!/usr/bin/env bash

cd ~/dotfiles/

jj describe -m "Update"
jj bookmark set main -r @
jj git push
jj new

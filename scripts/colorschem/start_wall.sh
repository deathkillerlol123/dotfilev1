#!/bin/bash

cd ~/dotfiles/scripts/colorschem/
value="$(cat last_wall.txt)"
echo $value

swww img "$value" --transition-type outer --transition-step 90

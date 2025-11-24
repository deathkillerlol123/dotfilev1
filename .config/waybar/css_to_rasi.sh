#!/bin/zsh

in="colors1.css"
out="${in:r}.rasi"  # zsh uses :r to strip extension

if [[ ! -f "$in" ]]; then
    echo "File $in not found!"
    exit 1
fi

echo "* {" > "$out"
sed -n 's/^[[:space:]]*--\(.*\): \(.*\);$/    \1: \2;/p' "$in" >> "$out"
echo "}" >> "$out"

echo "Converted $in → $out"

mv "$out" "$HOME/dotfiles/.config/rofi/"

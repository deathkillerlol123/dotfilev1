if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting
starship init fish | source
zoxide init fish | source

cd ~/dotfiles/nixos

# Created by `pipx` on 2026-04-06 14:38:47
set PATH $PATH /home/nixboom/.local/bin

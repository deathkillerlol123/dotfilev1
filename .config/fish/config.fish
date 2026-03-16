source ~/.config/fish/abbreviations.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting
starship init fish | source
zoxide init fish | source

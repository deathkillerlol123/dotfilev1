source ~/.config/fish/abbreviations.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias nrs='sudo nixos-rebuild switch --upgrade --flake ~/dotfiles/nixos'
alias gu='~/dotfiles/scripts/git_updater.sh'
alias up='~/dotfiles/scripts/updatesys_Nixos.sh'
alias windows='~/dotfiles/scripts/Boot-Windows10.sh'
alias total='gu && up'
alias ls='eza -a --tree -L 1'
alias zellij='zellij -l welcome'

set -U fish_greeting
starship init fish | source
zoxide init fish | source

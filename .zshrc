bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

setopt NO_BEEP

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias nrs='sudo nixos-rebuild switch --upgrade --flake ~/dotfiles/nixos'
alias gu='~/dotfiles/scripts/git_updater.sh'
alias up='~/dotfiles/scripts/updatesys_Nixos.sh'
alias windows='~/dotfiles/scripts/Boot-Windows10.sh'

alias total='gu && up'

alias ls='eza -a --tree -L 1'
alias zell='zellij -l welcome'
alias pyws="~/Documents/codes/venv/bin/python"
#alias archspin='~/3d-ascii-viewer/3d-ascii-viewer ~/arch-logo.obj'

export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:/usr/bin/python3"
#export PATH="$HOME/.local/bin"

# Created by `pipx` on 2026-03-11 14:52:41
export PATH="$PATH:/home/nixboom/.local/bin"

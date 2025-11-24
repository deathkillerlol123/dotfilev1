#source /home/archboom/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /home/archboom/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history



eval "$(starship init zsh)"

alias ls='eza -a --tree -L 1'
alias y='yazi'



export PATH=$PATH:/home/archboom/.spicetify
export PATH="$PATH:/home/archboom/.local/bin"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:/usr/bin/python3"

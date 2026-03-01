{config,pkgs, ...}:

{
 home.file."/.zshrc".text = ''
 bindkey "^[[3~" delete-char
 bindkey "^[[H" beginning-of-line
 bindkey "^[[F" end-of-line
 bindkey "^[[5~" up-line-or-history
 bindkey "^[[6~" down-line-or-history
 
 
 
 eval "$(starship init zsh)"
 
 alias ls='eza -a --tree -L 1'
 alias z='zellij -l welcome'
 alias pyws="~/Documents/codes/venv/bin/python"
 #alias archspin='~/3d-ascii-viewer/3d-ascii-viewer ~/arch-logo.obj'
 
 export PATH=$PATH:/home/archboom/.spicetify
 export PATH="$PATH:/home/archboom/.local/bin"
 export PATH="$HOME/.npm-global/bin:$PATH"
 export PATH="$PATH:/usr/bin/python3"
 
 
 #source /home/archboom/.config/broot/launcher/bash/br
 ''
 ;
}

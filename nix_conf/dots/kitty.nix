{config,pkgs, ...}:

{
 home.file."/.config/kitty/kitty.conf".text = ''
 include ~/dotfiles/.config/kitty/colors-kitty.conf

 uh huh

 copy_on_select yes
 
 enabled layout Tall, *
 
 background_opacity 0.95


 '';

}

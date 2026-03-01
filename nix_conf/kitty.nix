{config,pkgs, ...}:

{
 home.file."/.config/kitty/kitty.conf".text = ''
 include ~/dotfiles/.config/kitty/colors-kitty.conf

 copy_on_select yes
 
 enabled layout Tall, *
 
 background_opacity 0.95


 '';

}

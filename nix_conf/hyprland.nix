{config,pkgs, ...}:

{
 home.file."/.config/hypr/hyprland.conf".text = ''
 exec-once = swww-daemon
 exec-once = copyq &
 exec-once = dunst &
 
 exec-once = wayscriber --daemon
 
 exec-once = ~/dotfiles/scripts/niri_monitors/placement.sh
 
 exec-once = ~/dotfiles/scripts/colorschem/start_wall.sh
 exec-once = hyprpm reload
 exec-once = ~/dotfiles/scripts/disable-wifi-power.sh
 
 exec-once = ~/dotfiles/scripts/sys_sounds/sound_mon.sh
 
 monitor = ,preferred,auto,auto
 
 monitor = eDP-1,disable
 monitor = HDMI-A-1,1920x1080@60.00,0x0,1
 
 # Set programs that you use
 $terminal = kitty
 $fileManager = dolphin
 $menu = rofi -show drun
 
 env = XCURSOR_SIZE,24
 env = HYPRCURSOR_SIZE,24
 
 general {
   gaps_in = 0
   gaps_out = 0
   border_size = 0
   col.active_border = rgba(00feacff) # (33ccffee) # rgba(00ff99ee) 45deg
   col.inactive_border = rgba(595959aa)
   resize_on_border = true
   allow_tearing = false
   layout = dwindle
 } 
 decoration {
   rounding = 0
   rounding_power = 2
   active_opacity = 1
   inactive_opacity = 0.85
   fullscreen_opacity = 1
   shadow {
     enabled = false
     range = 4
     render_power = 3
     color = rgba(1a1a1aee)
   } 
   blur {
     enabled = false
     size = 3
     passes = 1
     vibrancy = 0.1696
   } 
 } 
 
 plugin {
   hyprwinrap {
     class = kitty-bg
     title = kitty-bg
     pos_x = 25
     pos_y = 30
     size_x = 40
     size_y = 70
   } 
 } 
 animations {
   enabled = yes, please :)
   bezier = easeOutQuint,   0.23, 1,    0.32, 1
   bezier = easeInOutCubic, 0.65, 0.05, 0.36, 1
   bezier = linear,         0,    0,    1,    1
   bezier = almostLinear,   0.5,  0.5,  0.75, 1
   bezier = quick,          0.15, 0,    0.1,  1
   animation = global,        1,     10,    default
   animation = border,        1,     5.39,  easeOutQuint
   animation = windows,       1,     4.79,  easeOutQuint
   animation = windowsIn,     1,     4.1,   easeOutQuint, popin 87%
   animation = windowsOut,    1,     1.49,  linear,       popin 87%
   animation = fadeIn,        1,     1.73,  almostLinear
   animation = fadeOut,       1,     1.46,  almostLinear
   animation = fade,          1,     3.03,  quick
   animation = layers,        1,     3.81,  easeOutQuint
   animation = layersIn,      1,     4,     easeOutQuint, fade
   animation = layersOut,     1,     1.5,   linear,       fade
   animation = fadeLayersIn,  1,     1.79,  almostLinear
   animation = fadeLayersOut, 1,     1.39,  almostLinear
   animation = workspaces,    1,     1.94,  almostLinear, fade
   animation = workspacesIn,  1,     1.21,  almostLinear, fade
   animation = workspacesOut, 1,     1.94,  almostLinear, fade
   animation = zoomFactor,    1,     7,     quick
 } 
 dwindle {
   pseudotile = true  
   preserve_split = true
 } 
 master {
   new_status = slave
   mfact = 0.45
   new_on_top = false
   orientation = right
 } 
 misc {
   force_default_wallpaper = 0 
   disable_hyprland_logo = true 
 } 
 input {
   kb_layout = us
   kb_variant = 
   kb_model = 
   kb_options = 
   kb_rules = 
   follow_mouse = 1
   sensitivity = 0 
   touchpad {
     natural_scroll = false
   } 
 } 
 
 gesture = 3, horizontal, workspace
 device {
   name = epic-mouse-v1
   sensitivity = -0.5
 } 
 $ultra = alt 
 bind = $ultra, R, exec, $terminal
 bind = $ultra, Q, killactive,
 bind = $ultra, O, exit,
 bind = $ultra, E, exec, $fileManager
 bind = $ultra, N, togglefloating,
 bind = $ultra, Space, exec, $menu
 bind = $ultra, X, togglesplit, 
 bind = $ultra, Delete, exec, wlogout
 bind = $ultra, F4, exec, playerctl pause && swaylock
 bind = $ultra shift, d, movewindow, r
 bind = $ultra shift, w, movewindow, u
 bind = $ultra shift, s, movewindow, d
 bind = $ultra, F, fullscreen
 bind = $ultra, C, exec, pgrep -x waybar > /dev/null && killall waybar || waybar
 bind = $ultra, G, exec, whatsdesk &
 bind = $ultra, V, exec, copyq toggle
 bind = , PRINT, exec, quickshell -c hyprquickshot
 bind = , F1, exec, ~/dotfiles/.config/waybar/random_wallpaper.sh
 bind = , F3, exec, ~/dotfiles/scripts/volume_increase.sh
 bind = , F2, exec, ~/dotfiles/scripts/volume_decrease.sh
 bind = , F4, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
 bind = , F5, exec, playerctl previous
 bind = , F6, exec, playerctl next
 bind = , F7, exec, playerctl play-pause
 bind = $ultra, L, exec, ~/dotfiles/scripts/layout_changer.sh
 bind = $ultra SHIFT, L, layoutmsg ,orientationcycle
 bind = $ultra SHIFT, TAB, layoutmsg, addmaster
 bind = $ultra, P, exec, wayscriber --active
 bind = $ultra, a, movefocus, l
 bind = $ultra, d, movefocus, r
 bind = $ultra, w, movefocus, u
 bind = $ultra, s, movefocus, d
 bind = $ultra, 1, workspace, 1
 bind = $ultra, 2, workspace, 2
 bind = $ultra, 3, workspace, 3
 bind = $ultra, 4, workspace, 4
 bind = $ultra, 5, workspace, 5
 bind = $ultra, 6, workspace, 6
 bind = $ultra, 7, workspace, 7
 bind = $ultra, 8, workspace, 8
 bind = $ultra, 9, workspace, 9
 bind = $ultra, 0, workspace, 10
 bind = $ultra CTRL, 1, movetoworkspace, 1
 bind = $ultra CTRL, 2, movetoworkspace, 2
 bind = $ultra CTRL, 3, movetoworkspace, 3
 bind = $ultra CTRL, 4, movetoworkspace, 4
 bind = $ultra CTRL, 5, movetoworkspace, 5
 bind = $ultra CTRL, 6, movetoworkspace, 6
 bind = $ultra CTRL, 7, movetoworkspace, 7
 bind = $ultra CTRL, 8, movetoworkspace, 8
 bind = $ultra CTRL, 9, movetoworkspace, 9
 bind = $ultra CTRL, 0, movetoworkspace, 10
 bind = $ultra CTRL, right, movetoworkspace, +1
 bind = $ultra CTRL, left, movetoworkspace, -1
 bind = $ultra SHIFT, mouse_down, workspace, e+1
 bind = $ultra SHIFT, mouse_up, workspace, e-1
 bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
 bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
 bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
 bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
 bindl = , XF86AudioNext, exec, playerctl next
 bindl = , XF86AudioPause, exec, playerctl play-pause
 bindl = , XF86AudioPlay, exec, playerctl play-pause
 bindl = , XF86AudioPrev, exec, playerctl previous

 ''
 ;
}

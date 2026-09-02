{...}: {
  flake.homeModules.nbmango = {inputs, ...}: {
    home.file.".local/bin/wayland_autostart" = {
      source = ../home/scripts/autostart/wayland_autostart.sh;
      executable = true;
    };
    imports = [inputs.mango.hmModules.mango];
    wayland.windowManager.mango = {
      enable = true;
      autostart_sh = ''
        wayland_autostart
      '';
      extraConfig = ''
        bind = SUPER,r,reload_config
        bind = Alt,r,spawn,ghostty
        bind = Alt,q,killclient
        bind = Alt,space,spawn,rofi -show drun
        bind = Alt,o,spawn_shell,~/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/clean_exit.sh
        bind = Alt,V,spawn_shell,copyq toggle
        bind = Alt,I,togglefloating

        bind = NONE,Print,spawn_shell,grim -g "$(slurp)" - | swappy -f - &
        bind = NONE,F1,spawn_shell,bash ~/dotfiles/nixos/modules/hosts/users/nixboom/home/.config/waybar/random_wallpaper.sh
        bind = NONE,F2,spawn_shell,~/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/sys_sounds/volume_decrease.sh
        bind = NONE,F3,spawn_shell,~/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/sys_sounds/volume_increase.sh
        bind = NONE,F4,spawn_shell,~/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/sys_sounds/volume_mute.sh
        bind = NONE,F5,spawn,playerctl previous
        bind = NONE,F6,spawn,playerctl next
        bind = NONE,F7,spawn,playerctl play-pause

        bind = Alt,A,focusdir,left
        bind = Alt,D,focusdir,right
        bind = Alt,W,focusdir,up
        bind = Alt,S,focusdir,down
        bind = Alt+SHIFT,W,exchange_client,up
        bind = Alt+SHIFT,S,exchange_client,down
        bind = Alt+SHIFT,A,exchange_client,left
        bind = Alt+SHIFT,D,exchange_client,right
        bind = Alt+SHIFT,j,focusmon,left
        bind = Alt+SHIFT,l,focusmon,right
        bind = Alt+SHIFT,i,focusmon,up
        bind = Alt+SHIFT,k,focusmon,down
        bind = Alt+CTRL,j,tagmon,left
        bind = Alt+CTRL,l,tagmon,right
        bind = Alt+CTRL,i,tagmon,up
        bind = Alt+CTRL,k,tagmon,down

        bind = Alt,g,toggleglobal
        bind = Alt,Tab,toggleoverview
        bind = Alt+CTRL,f,togglefullscreen
        bind = Alt+SHIFT,f,togglefakefullscreen
        bind = SUPER,left,movewin,-10,+0
        bind = SUPER,right,movewin,+10,+0
        bind = SUPER,up,movewin,+0,-10
        bind = SUPER,down,movewin,+0,+10
        bind = Alt,M,switch_layout
        bind = Alt,P,incnmaster,+1

        bind = Alt,1,view,1,0
        bind = Alt,2,view,2,0
        bind = Alt,3,view,3,0
        bind = Alt,4,view,4,0
        bind = Alt,5,view,5,0
        bind = Alt,6,view,6,0
        bind = Alt,7,view,7,0
        bind = Alt,8,view,8,0
        bind = Alt,9,view,9,0
        bind = Alt+SHIFT,1,tag,1,0
        bind = Alt+SHIFT,2,tag,2,0
        bind = Alt+SHIFT,3,tag,3,0
        bind = Alt+SHIFT,4,tag,4,0
        bind = Alt+SHIFT,5,tag,5,0
        bind = Alt+SHIFT,6,tag,6,0
        bind = Alt+SHIFT,7,tag,7,0
        bind = Alt+SHIFT,8,tag,8,0
        bind = Alt+SHIFT,9,tag,9,0
        bind = Alt+CTRL,up,resizewin,+0,-50
        bind = Alt+CTRL,down,resizewin,+0,+50
        bind = Alt+CTRL,left,resizewin,-50,+0
        bind = Alt+CTRL,right,resizewin,+50,+0

        windowrule = appid:ghostty,focused_opacity:0.85
        windowrule = appid:ghostty,unfocused_opacity:0.85
        windowrule = appid:firefox,tags:1,isfakefullscreen:1
        windowrule = appid:discord,tags:2
        windowrule = appid:whatsapp-electron,tags:2
        windowrule = isglobal:1,isoverlay:1

        mousebind = Alt,btn_left,moveresize,curmove
        mousebind = Alt,btn_right,moveresize,curresize

        gappih = 0
        gappiv = 0
        gappoh = 0
        gappov = 0
        scratchpad_width_ratio = 0.8
        scratchpad_height_ratio = 0.9
        borderpx = 0
        rootcolor = 0x201b14ff
        bordercolor = 0x201b14ff
        focuscolor = 0xfad060FF
        maximizescreencolor = 0x89aa61ff
        urgentcolor = 0xad401fff
        scratchpadcolor = 0x516c93ff
        globalcolor = 0xb153a7ff
        overlaycolor = 0x14a57cff

        xwayland_persistence = 1
        touch_enable = 1
        touch_map_to_mon = eDP-1

        scroller_structs = 20
        scroller_default_proportion = 0.8
        scroller_focus_center = 0
        scroller_prefer_center = 0
        edge_scroller_pointer_focus = 1
        scroller_default_proportion_single = 1.0
        scroller_proportion_preset = 0.5, 0.8, 1.0
        new_is_master = 1
        default_mfact = 0.55
        default_nmaster = 1
        smartgaps = 0
        hotarea_size = 10
        enable_hotarea = 0
        hotarea_corner = 0
        overviewgappi = 5
        overviewgappo = 15

        tagrule = id:1,layout_name:tile
        tagrule = id:2,layout_name:tile
        tagrule = id:3,layout_name:tile
        tagrule = id:4,layout_name:tile
        tagrule = id:5,layout_name:tile
        tagrule = id:6,layout_name:tile
        tagrule = id:7,layout_name:tile
        tagrule = id:8,layout_name:tile
        tagrule = id:9,layout_name:tile

        syncobj_enable = 1
        no_border_when_single = 1
        axis_bind_apply_timeout = 100
        focus_on_activate = 0
        idleinhibit_ignore_visible = 0
        mouse_natural_scrolling = 0
        sloppyfocus = 1
        warpcursor = 1
        cursor_hide_timeout = 5
        cursor_hide_on_keypress = 0
        enable_floating_snap = 0
        snap_distance = 30
        cursor_size = 24
        drag_tile_to_tile = 1
        focus_cross_monitor = 1
        focus_cross_tag = 0
        scratchpad_cross_monitor = 0
        repeat_rate = 100
        repeat_delay = 300
        numlockon = 1
        xkb_rules_layout = us

        #trackpad
        disable_trackpad = 0
        tap_to_click = 1
        tap_and_drag = 1
        drag_lock = 1
        trackpad_natural_scrolling = 1
        trackpad_accel_profile = 2
        trackpad_disable_while_typing = 0
        trackpad_left_handed = 0
        trackpad_middle_button_emulation = 0
        swipe_min_threshold = 1
        button_map = 1
        allow_tearing = 1

        #Appearence
        blur = 0
        blur_layer = 0
        blur_optimized = 1
        blur_params_num_passes = 2
        blur_params_radius = 5
        blur_params_noise = 0.02
        blur_params_brightness = 0.9
        blur_params_contrast = 0.9
        blur_params_saturation = 1.2
        shadows = 0
        layer_shadows = 0
        shadow_only_floating = 1
        shadows_size = 10
        shadows_blur = 15
        shadows_position_x = 0
        shadows_position_y = 0
        shadowscolor = 0x000000ff
        border_radius = 0
        no_radius_when_single = 0
        focused_opacity = 1.0
        unfocused_opacity = 0.65
        animations = 0
        layer_animations = 1
        animation_type_open = slide
        animation_type_close = slide
        animation_fade_in = 1
        animation_fade_out = 1
        tag_animation_direction = 1
        zoom_initial_ratio = 0.3
        zoom_end_ratio = 0.8
        fadein_begin_opacity = 0.5
        fadeout_begin_opacity = 0.8
        animation_duration_move = 200
        animation_duration_open = 200
        animation_duration_tag = 350
        animation_duration_close = 0
        animation_duration_focus = 0
        animation_curve_open = 0.46, 1.0, 0.29, 1
        animation_curve_move = 0.46, 1.0, 0.29, 1
        animation_curve_tag = 0.46, 1.0, 0.29, 1
        animation_curve_close = 0.08, 0.92, 0, 1
        animation_curve_focus = 0.46, 1.0, 0.29, 1
        animation_curve_opafadeout = 0.5, 0.5, 0.5, 0.5
        animation_curve_opafadein = 0.46, 1.0, 0.29, 1
      '';
    };
  };
}

{...}: {
  flake.homeModules.nbhypr = {...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
      settings = {
        env = ["XCURSOR_SIZE,24" "HYPRCURSOR_SIZE,24"];
        monitor = ["HDMI-A-1,preferred,auto,auto"];
        exec-once = ["~/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/autostart/autostart.sh"];
        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 0;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
        };
        decoration = {
          rounding = 0;
          rounding_power = 1.0;
          active_opacity = 1.0;
          inactive_opacity = 0.65;
          shadow = {
            enabled = false;
            range = 4;
            render_power = 3;
            color = "0xee1a1a1a";
          };
          blur = {
            enabled = false;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            "global,1,10,default"
            "border,1,5.39,easeOutQuint"
            "windows,1,4,easy"
            "windowsIn,1,4.1,easy,popin 87%"
            "windowsOut,1,1.49,linear,popin 87%"
            "fadeIn,1,1.73,almostLinear"
            "fadeOut,1,1.46,almostLinear"
            "fade,1,3.03,quick"
            "layers,1,3.81,easeOutQuint"
            "layersIn,1,4,easeOutQuint,fade"
            "layersOut,1,1.5,linear,fade"
            "fadeLayersIn,1,1.79,almostLinear"
            "fadeLayersOut,1,1.39,almostLinear"
            "workspaces,1,1.94,almostLinear,fade"
            "workspacesIn,1,1.21,almostLinear,fade"
            "workspacesOut,1,1.94,almostLinear,fade"
            "zoomFactor,1,7,quick"
          ];
        };
        dwindle = {
          preserve_split = true;
        };
        master = {
          new_status = "slave";
        };
        scrolling = {
          fullscreen_on_one_column = true;
        };
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };
        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = false;
          };
        };
        gesture = [
          "3,horizontal,workspace"
        ];
        device = {
          "epic-mouse-v1" = {
            sensitivity = -0.5;
          };
        };
        "$mainMod" = "ALT";
        bind = [
          "$mainMod, Q, killactive"
          "$mainMod, R, exec, ghostty"
          "$mainMod, O, exec, ~/dotfiles/nixos/modules/hosts/users/nixboom/home/scripts/clean_exit.sh"
          "$mainMod, I, togglefloating"
          "$mainMod, SPACE, exec, rofi -show drun"
          "$mainMod, M, pseudo"
          "$mainMod, A, movefocus, l"
          "$mainMod, D, movefocus, r"
          "$mainMod, W, movefocus, u"
          "$mainMod, S, movefocus, d"
          "$mainMod SHIFT, A, swapwindow, l"
          "$mainMod SHIFT, D, swapwindow, r"
          "$mainMod SHIFT, W, swapwindow, u"
          "$mainMod SHIFT, S, swapwindow, d"
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          "$mainMod CTRL, 1, movetoworkspace, 1"
          "$mainMod CTRL, 2, movetoworkspace, 2"
          "$mainMod CTRL, 3, movetoworkspace, 3"
          "$mainMod CTRL, 4, movetoworkspace, 4"
          "$mainMod CTRL, 5, movetoworkspace, 5"
          "$mainMod CTRL, 6, movetoworkspace, 6"
          "$mainMod CTRL, 7, movetoworkspace, 7"
          "$mainMod CTRL, 8, movetoworkspace, 8"
          "$mainMod CTRL, 9, movetoworkspace, 9"
          "$mainMod CTRL, 0, movetoworkspace, 10"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+, repeat"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-, repeat"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle, repeat"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle, repeat"
          ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+, repeat"
          ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-, repeat"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
        windowrule = [
          "match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false, no_focus true"
          "match:class ^hyprland-run$, float true, move 20 monitor_h-120"
        ];
      };
    };
  };
}

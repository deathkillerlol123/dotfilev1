{...}: {
  flake.homeModules.nbwezterm = {...}: {
    programs.wezterm = {
      enable = true;
      settings = {
        enable_tab_bar = true;
        hide_tab_bar_if_only_one_tab = true;
        warn_about_missing_glyphs = false;
        use_fancy_tab_bar = false;
        show_close_tab_button_in_tabs = false;
        enable_scroll_bar = false;
        window_padding = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
        color_scheme = "Tokyo Night Storm";
        font_size = 13;
        font = {
          family = "JetBrains Mono";
        };
        adjust_window_size_when_changing_font_size = false;
        colors = {
          cursor_bg = "#7aa2f7";
          cursor_border = "#7aa2f7";
        };
      };
    };
  };
}

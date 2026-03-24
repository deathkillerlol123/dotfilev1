local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

wezterm.on('window-focus-changed', function(window, pane)
  local has_selection = window:get_selection_text_for_pane(pane) ~= ""
  if has_selection then
    window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
  end
end)



config.window_decorations = 'RESIZE'
config.window_close_confirmation = 'NeverPrompt'


config.enable_tab_bar = false
--config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.show_close_tab_button_in_tabs = false


config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}


config.color_scheme = 'Tokyo Night Storm'
config.font = wezterm.font('FiraCode Nerd Font Mono')
config.font_size = 13
config.adjust_window_size_when_changing_font_size = false

config.colors = {
  cursor_bg = "#7aa2f7",
  cursor_border = "#7aa2f7",
}
-- Finally, return the configuration to wezterm:
return config

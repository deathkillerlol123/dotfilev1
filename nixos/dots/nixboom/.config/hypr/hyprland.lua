hl.on("hyprland.start", function()
    hl.exec_cmd("~/dotfiles/scripts/autostart/autostart.sh")
end)

local terminal = "wezterm"
local menu = "rofi -show drun"

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

hl.config({
      ecosystem = {
	 no_update_news = true,
      },
    general = {
        gaps_in  = 0,
        gaps_out = 0,
        border_size = 0,
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding       = 0,
        rounding_power = 0,
        active_opacity   = 1.0,
        inactive_opacity = .65,
        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "slave",
        mfact = 0.45,
        new_on_top = false,
        orientation = "right",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

local ultra = "ALT"
hl.bind(ultra .. " + " .. "R", hl.dsp.exec_cmd("wezterm"))
hl.bind(ultra .. " + " .. "Q", hl.dsp.window.close())
hl.bind(ultra .. " + " .. "O", hl.dsp.exit())
hl.bind(ultra .. " + " .. "N", hl.dsp.window.float())
hl.bind(ultra .. " + " .. "Space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(ultra .. " + " .. "X", hl.dsp.layout("togglesplit"))
hl.bind(ultra .. " + " .. "G", hl.dsp.window.pin({window}))

hl.bind("F8", hl.dsp.exec_cmd("playerctl pause && swaylock"))

hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. "a", hl.dsp.window.swap({direction = "left"}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. "d", hl.dsp.window.swap({direction = "right"} ))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. "w", hl.dsp.window.swap({direction = "up"} ))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. "s", hl.dsp.window.swap({direction = "down"} ))

hl.bind(ultra .. " + " .. "CTRL" .. " + " .. "F", hl.dsp.window.fullscreen())

hl.bind(ultra .. " + " .. "V", hl.dsp.exec_cmd("copyq toggle"))

hl.bind("F1", hl.dsp.exec_cmd("~/dotfiles/.config/waybar/random_wallpaper.sh"))
hl.bind("F3", hl.dsp.exec_cmd("~/dotfiles/scripts/sys_sounds/volume_increase.sh"))
hl.bind("F2", hl.dsp.exec_cmd("~/dotfiles/scripts/sys_sounds/volume_decrease.sh"))
hl.bind("F4", hl.dsp.exec_cmd("~/dotfiles/scripts/sys_sounds/volume_mute.sh"))
hl.bind("F5", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("F6", hl.dsp.exec_cmd("playerctl next"))
hl.bind("F7", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind(ultra .. " + " .. "M", hl.dsp.layout("orientationcycle"))
hl.bind(ultra .. " + " .. "a", hl.dsp.focus({direction = "left" }))
hl.bind(ultra .. " + " .. "d", hl.dsp.focus({direction = "right" }))
hl.bind(ultra .. " + " .. "w", hl.dsp.focus({direction = "up" }))
hl.bind(ultra .. " + " .. "s", hl.dsp.focus({direction = "down" }))

hl.bind(ultra .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))
hl.bind(ultra .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))
hl.bind(ultra .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))
hl.bind(ultra .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))
hl.bind(ultra .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))
hl.bind(ultra .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))
hl.bind(ultra .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))
hl.bind(ultra .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))
hl.bind(ultra .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))
hl.bind(ultra .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({workspace=1}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({workspace=2}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({workspace=3}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({workspace=4}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({workspace=5}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({workspace=6}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({workspace=7}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({workspace=8}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({workspace=9}))
hl.bind(ultra .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({workspace=10}))

hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

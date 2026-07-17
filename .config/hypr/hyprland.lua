-- Hyprland Lua config

local terminal = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local browser = "brave"
local mainMod = "SUPER"

--------------------
-- MONITORS --
--------------------
hl.monitor({ output = "eDP-1", mode = "1366x768@60", position = "0x0", scale = 1 })
hl.monitor({ output = "VGA-1", mode = "1280x1024@60", position = "1366x0", scale = 1 })

-------------------------
-- ENVIRONMENT VARS --
-------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("TERMINAL", terminal)

-------------------------
-- AUTOSTART (on boot) --
-------------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("kwalletd6")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("xdg-mime default gwenview.desktop image/png")
    hl.exec_cmd("xdg-mime default gwenview.desktop image/jpeg")
end)

-------------------------
-- LOOK AND FEEL --
-------------------------
hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})

hl.config({
    animations = {
        enabled = false,
        bezier = {
            { name = "easeOutQuint",   x0 = 0.23, y0 = 1,    x1 = 0.32, y1 = 1 },
            { name = "easeInOutCubic", x0 = 0.65, y0 = 0.05, x1 = 0.36, y1 = 1 },
            { name = "linear",         x0 = 0,    y0 = 0,    x1 = 1,    y1 = 1 },
            { name = "almostLinear",   x0 = 0.5,  y0 = 0.5,  x1 = 0.75, y1 = 1 },
            { name = "quick",          x0 = 0.15, y0 = 0,    x1 = 0.1,  y1 = 1 },
        },
        animation = {
            { name = "global",        enabled = true, speed = 1,    curve = "default" },
            { name = "border",        enabled = true, speed = 5.39, curve = "easeOutQuint" },
            { name = "windows",       enabled = true, speed = 4.79, curve = "easeOutQuint" },
            { name = "windowsIn",     enabled = true, speed = 4.1,  curve = "easeOutQuint",  style = "popin 87%" },
            { name = "windowsOut",    enabled = true, speed = 1.49, curve = "linear",        style = "popin 87%" },
            { name = "fadeIn",        enabled = true, speed = 1.73, curve = "almostLinear" },
            { name = "fadeOut",       enabled = true, speed = 1.46, curve = "almostLinear" },
            { name = "fade",          enabled = true, speed = 3.03, curve = "quick" },
            { name = "layers",        enabled = true, speed = 3.81, curve = "easeOutQuint" },
            { name = "layersIn",      enabled = true, speed = 4,    curve = "easeOutQuint",  style = "fade" },
            { name = "layersOut",     enabled = true, speed = 1.5,  curve = "linear",        style = "fade" },
            { name = "fadeLayersIn",  enabled = true, speed = 1.79, curve = "almostLinear" },
            { name = "fadeLayersOut", enabled = true, speed = 1.39, curve = "almostLinear" },
            { name = "workspaces",    enabled = true, speed = 1.94, curve = "almostLinear",  style = "fade" },
            { name = "workspacesIn",  enabled = true, speed = 1.21, curve = "almostLinear",  style = "fade" },
            { name = "workspacesOut", enabled = true, speed = 1.94, curve = "almostLinear",  style = "fade" },
            { name = "zoomFactor",    enabled = true, speed = 7,    curve = "quick" },
        },
    },
})

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})

-------------
-- INPUT --
-------------
hl.config({
    input = {
        kb_layout = "us, ara",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:win_space_toggle",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})


---------------
-- GESTURES --
---------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

----------------
-- KEYBINDS --
----------------
-- Launch apps
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",       hl.dsp.window.close())
hl.bind(mainMod .. " + W",       hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E",       hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R",       hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Z",       hl.dsp.exec_cmd("emacs"))
hl.bind(mainMod .. " + O",       hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + T",       hl.dsp.exec_cmd("Telegram"))

-- Reload config + random wallpaper
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(
    "hyprctl dispatch 'hl.dsp.exec_cmd(\"hyprpaper\")' 2>/dev/null; " ..
    "sleep 0.5; " ..
    "f=$(find /mnt/hdd/Favorites -type f \\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \\) -print | shuf -n 1); " ..
    'hyprctl hyprpaper wallpaper "eDP-1,$f"; ' ..
    "hyprctl reload"
))

-- Toggle float
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))

-- Move focus (vim keys)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Switch workspaces
for i = 1, 10 do
    local n = i == 10 and 0 or i
    hl.bind(mainMod .. " + " .. n,            hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. n,    hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + A",            hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + A",    hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Cycle workspaces
hl.bind(mainMod .. " + Tab",          hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Tab",  hl.dsp.focus({ workspace = "m-1" }))

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Multimedia keys (volume, brightness)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),     { repeating = true })
hl.bind("XF86AudioMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                { repeating = true })

-- Media keys (playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Extra volume/brightness
hl.bind(mainMod .. " + ALT + equal", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind(mainMod .. " + ALT + minus", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind(mainMod .. " + M",           hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind(mainMod .. " + ALT + O",     hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"))
hl.bind(mainMod .. " + ALT + I",     hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"))

-- Screenshots
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -zm region --clipboard-only"))
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd("hyprshot -zm region"))

-- Clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Emote picker
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("/home/dt/scripts/emote"))

------------------------------
-- WINDOW RULES --
------------------------------
-- App workspace assignments
hl.window_rule({ match = { class = "^(firefox)$" },        workspace = "2" }) --works
hl.window_rule({ match = { class = "^(obsidian)$" },       workspace = "9" }) --works
hl.window_rule({ match = { class = "^(discord)$" },        workspace = "10" }) --works

hl.window_rule({ match = { class = "^(steam)$" },             workspace = "1" })
hl.window_rule({ match = { class = "^(brave\\-browser)$" },   workspace = "2" })
hl.window_rule({ match = { class = "^(org\\.kde\\.okular)$" }, workspace = "4" })
hl.window_rule({ match = { class = "^(gimp)$" },              workspace = "5" })
hl.window_rule({ match = { class = "^(org\\.kde\\.kdenlive)$" },          workspace = "5" })
hl.window_rule({ match = { class = "^(ZenNotes)$" },          workspace = "9" })
hl.window_rule({ match = { class = "^(org\\.telegram\\.desktop)$" }, workspace = "10" })

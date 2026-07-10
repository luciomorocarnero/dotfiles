local mainMod = "SUPER"

local function keys(...)
	return table.concat({ ... }, " + ")
end

-- APPS

-- terminal (kitty)
hl.bind(keys(mainMod, "Return"), hl.dsp.exec_cmd("kitty"))
-- teminal (tmux)
hl.bind(keys(mainMod, "SHIFT", "Return"), hl.dsp.exec_cmd("kitty ~/.tmux/sessions/local.sh"))
-- filemanager (yazi)
hl.bind(keys(mainMod, "E"), hl.dsp.exec_cmd("kitty -e yazi"))
-- filemanager (thunar)
hl.bind(keys(mainMod, "SHIFT", "E"), hl.dsp.exec_cmd("thunar"))
-- color picker
hl.bind(keys(mainMod, "SHIFT", "P"), hl.dsp.exec_cmd("hyprpicker -a"))

-- SCREEN

-- turn on screen
hl.bind(keys(mainMod, "F11"), hl.dsp.dpms({ action = "enable" }), { locked = true })
hl.bind(keys(mainMod, "SHIFT", "E"), function()
	hl.dispatch(hl.dsp.dpms({ action = "enable" }))
	hl.exec_cmd("pkill hyprlock")
end, { locked = true })

-- turn off screen
hl.bind(keys(mainMod, "F12"), function()
	hl.exec_cmd("pidof hyprlock || hyprlock")
	hl.dispatch(hl.dsp.dpms({ action = "disable" }))
end, { locked = true })

-- MENUS

hl.bind(keys(mainMod, "Delete"), hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu.sh"))
hl.bind(keys(mainMod, "X"), hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu.sh"))
hl.bind(keys(mainMod, "I"), hl.dsp.exec_cmd("~/.config/rofi/scripts/icons.sh"))
hl.bind(keys(mainMod, "code:118"), hl.dsp.exec_cmd("~/.config/rofi/scripts/hyprsunset.sh"))
hl.bind(keys(mainMod, "B"), hl.dsp.exec_cmd("~/.config/rofi/scripts/browser.sh"))
hl.bind(keys(mainMod, "SHIFT", "B"), hl.dsp.exec_cmd("~/.config/rofi/scripts/browser.sh -n"))
hl.bind(keys(mainMod, "D"), hl.dsp.exec_cmd('rofi -show run -i --no-show-icons -p "Apps"'))
hl.bind(keys(mainMod, "C"), hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- WORKSPACES AND WINDOWS

-- close window
hl.bind(keys(mainMod, "Q"), hl.dsp.window.close())

-- make workspaces
for i = 1, 8 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(keys(mainMod, key), function()
		-- move to workspace
		hl.dispatch(hl.dsp.focus({ workspace = i }))
		-- hide special ws if there is one
		local s_ws = hl.get_active_special_workspace()
		if s_ws then
			hl.dispatch(hl.dsp.workspace.toggle_special(string.match(s_ws.name, ":(.*)")))
		end
	end)
	hl.bind(keys(mainMod, "SHIFT", key), hl.dsp.window.move({ workspace = i }))
end

-- special F[1-4]
for i = 1, 4 do
	local key = "F" .. i
	hl.bind(keys(mainMod, key), hl.dsp.workspace.toggle_special(key))
	hl.bind(keys(mainMod, "SHIFT", key), hl.dsp.window.move({ workspace = "special:" .. key }))
end

-- stats workspace
hl.bind(keys(mainMod, "0"), hl.dsp.workspace.toggle_special("stats"))
-- notes workspace
hl.bind(keys(mainMod, "9"), hl.dsp.workspace.toggle_special("notes"))

-- move window and change focus
local directions = {
	{ key = "H", arrow = "LEFT", dir = "left" },
	{ key = "J", arrow = "DOWN", dir = "down" },
	{ key = "K", arrow = "UP", dir = "up" },
	{ key = "L", arrow = "RIGHT", dir = "right" },
}
for _, m in ipairs(directions) do
	hl.bind(keys(mainMod, m.key), hl.dsp.focus({ direction = m.dir }))
	hl.bind(keys(mainMod, "SHIFT", m.key), hl.dsp.window.move({ direction = m.dir }))
	hl.bind(keys(mainMod, m.arrow), hl.dsp.focus({ direction = m.dir }))
	hl.bind(keys(mainMod, "SHIFT", m.arrow), hl.dsp.window.move({ direction = m.dir }))
end

-- toggle flaot
hl.bind(keys(mainMod, "V"), hl.dsp.window.float())

-- drag with mouse
hl.bind(keys(mainMod, "mouse:272"), hl.dsp.window.drag(), { mouse = true })

-- maximize window
hl.bind(
	keys(mainMod, "F"),
	hl.dsp.window.fullscreen({
		mode = "maximized",
		action = "toggle",
	})
)
-- fullscreen window
hl.bind(
	keys(mainMod, "SHIFT", "F"),
	hl.dsp.window.fullscreen({
		mode = "fullscreen",
		action = "toggle",
	})
)
-- fullscreen reset
hl.bind(
	keys(mainMod, "CONTROL", "F"),
	hl.dsp.window.fullscreen_state({
		internal = 0,
		client = 0,
	})
)
-- fake fullscreen
hl.bind(
	keys(mainMod, "ALT", "F"),
	hl.dsp.window.fullscreen_state({
		internal = 0,
		client = 2,
	})
)

-- change workspace layout (dwindle/master)
hl.bind(keys(mainMod, "Z"), function()
	local ws = hl.get_active_workspace()
	local layout = ws.tiled_layout == "dwindle" and "master" or "dwindle"
	hl.workspace_rule({ workspace = ws.id, layout = layout })
	hl.notification.create({ text = "Layout: " .. layout, duration = 5000, icon = "ok" })
end)

-- search windows
hl.bind(keys(mainMod, "TAB"), hl.dsp.exec_cmd('rofi -show window -i --no-show-icons -p "Windows"'))

-- LAPTOP

local audio_notif =
	[[dunstify -h string:x-dunst-stack-tag:volume -a "Sistema" "Volumen: $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')%" -h int:value:"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')"]]

local bright_notif =
	[[dunstify -h string:x-dunst-stack-tag:brightness -a "Sistema" "Brillo: $(brightnessctl i -m | cut -d, -f4)" -h int:value:"$(brightnessctl i -m | cut -d, -f4 | tr -d '%')"]]

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && " .. audio_notif),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && " .. audio_notif),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && " .. "pkill -RTMIN+8 waybar"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && " .. bright_notif),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && " .. bright_notif),
	{ locked = true, repeating = true }
)

-- media
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- screenshot
hl.bind("code:107", hl.dsp.exec_cmd("~/.config/rofi/scripts/screenshot.sh"))

-- GESTURES

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.notification.create({ text = "I just swiped on my trackpad!", duration = 5000, icon = "ok" })
	end,
})

-- GROUPS
hl.bind(keys(mainMod, "G"), hl.dsp.group.toggle())
hl.bind(keys(mainMod, "SHIFT", "G"),hl.dsp.group.lock_active({action = "toggle"}) )
local group_direction = {
	{ key = "L", forward = true },
	{ key = "J", forward = true },
	{ key = "LEFT", forward = true },
	{ key = "H", forward = false },
	{ key = "K", forward = false },
	{ key = "RIGHT", forward = false },
}
for _, m in ipairs(group_direction) do
	if m.forward then
		hl.bind(keys(mainMod, "ALT", m.key), hl.dsp.group.next())
		hl.bind(keys(mainMod, "SHIFT", "ALT", m.key), hl.dsp.group.move_window({ forward = m.forward }))
	else
		hl.bind(keys(mainMod, "ALT", m.key), hl.dsp.group.prev())
		hl.bind(keys(mainMod, "SHIFT", "ALT", m.key), hl.dsp.group.move_window({ forward = m.forward }))
	end
end

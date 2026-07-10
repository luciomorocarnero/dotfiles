-- WINDOWS RULES

hl.window_rule({
	match = {
		class = "[Ss]team",
	},
	workspace = 4,
})

hl.window_rule({
	match = {
		class = "[Ss]potify",
	},
	workspace = "special:F2",
	float = true,
	size = { "(monitor_w*0.8)", "(monitor_h*0.8)" },
	center = true,
})

hl.window_rule({
	match = {
		class = "[Dd]iscord",
	},
	workspace = "special:F3",
})

-- WORKSPACES RULES

hl.workspace_rule({
	workspace = "1",
	layout = "master",
})

hl.workspace_rule({
	workspace = "special:notes",
	on_created_empty = "kitty -e nvim ~/Notes/fast.md",
	gaps_out = 150,
})

hl.workspace_rule({
	workspace = "special:stats",
	layout = "master",
	on_created_empty = "kitty -e btm & sleep 0.2 && (kitty -e wiremix & sleep 0.2 && kitty -e bluetui)",
})

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
  name = "disable group animation In/Out",
  animation = "popin 100%",
  match = {
    group = true
  }
})

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 8,

		border_size = 1,

		col = {
			active_border = "rgba(ffffffff)",
			inactive_border = "rgba(595959ff)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = true,

		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,

		active_opacity = 1.0,
		-- inactive_opacity = 0.95,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.config({
	dwindle = {
		force_split = 2,
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "slave",
		mfact = 0.65,
	},
})

hl.config({
	misc = {
		font_family = "CaskaydiaCove Nerd Font",
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = false,
		exit_window_retains_fullscreen = false,
	},
})

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:swapescape, compose:ins",
		kb_rules = "",

		numlock_by_default = true,

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.config({
	group = {
		group_on_movetoworkspace = true,
		col = {
			border_active = "rgba(ffffffff)",
			border_inactive = "rgba(595959ff)",
		},
		groupbar = {
			height = 25,
			indicator_gap = 0,
			rounding = 0,
			gaps_out = 0,
			gaps_in = 0,
			font_size = 13,
			text_color_inactive = "rgba(aaaaaaff)",
			col = {
				active = "rgba(ffffffff)",
				inactive = "rgb(000000)",
			},
		},
	},
})

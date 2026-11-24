hl.on("hyprland.start", function()
  -- hl.exec_cmd("hypridle") manage by systemd
  hl.exec_cmd("waybar")
  hl.exec_cmd("awww-daemon && ~/.config/rofi/scripts/wallpaper.sh -r")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("rfkill unblock bluetooth")
  -- hl.exec_cmd("hyprpm reload -n")
end)

-- Open apps on workspace start
local on_create_workspace = {
	["special:notes"] = {
		"kitty --working-directory ~/Notes/ -e nvim ~/Notes/fast.md",
	},
	["special:stats"] = {
		"kitty -e btm",
		"kitty -e wiremix",
		"kitty -e bluetui",
		"kitty -e impala",
	},
	["special:F2"] = {
		"spotify-launcher",
	},
	["special:F3"] = {
		"discord",
	},
}
hl.on("workspace.created", function(ws)
	local windows = on_create_workspace[ws.name]

	if not windows or not ws.is_empty then
		return
	end

	local commands = {}

	for _, cmd in ipairs(windows) do
		table.insert(commands, cmd .. " & sleep 0.2" )
	end
	hl.exec_cmd(table.concat(commands, " &&"))
end)

-- Wezterm Config
local wezterm = require("wezterm")
local mux = wezterm.mux

local colors = {
	foreground = "#E5F3FA",
	background = "#131B25",
	split = "#2D4F67",
	red = "#FF5D62",
	green = "#95C561",
	cyan = "#71BAF2",
	pink = "#ECB2F0",
	teal = "#4DB5BD",
	teal2 = "#2DF4C0",
	grey = "#B0BEC5",
	grey2 = "#7C8083",
	blue = "#1C4474",
	purple = "#D67AD2",
	yellow = "#F9E2AF",
	black = "#1A1A1A",
	black2 = "#3A3432",
}

local process_icon = function(tab)
	local icon = {
		["zsh"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.dev_terminal },
		},
		["nvim"] = {
			{ Foreground = { Color = colors.teal2 } },
			{ Text = wezterm.nerdfonts.custom_vim },
		},
		["git"] = {
			{ Text = wezterm.nerdfonts.dev_git },
		},
		["lazygit"] = {
			{ Text = wezterm.nerdfonts.dev_git },
		},
		["ssh"] = {
			{ Text = wezterm.nerdfonts.fa_server },
		},
	}

	local name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	return wezterm.format(icon[name] or {
		{ Forground = { Color = colors.split } },
		{ Text = string.format("[%s]", name) },
	})
end

local basename = function(tab)
	local dir = tab.active_pane.current_working_dir
	local base = string.gsub(dir, "(.*[/\\])(.*)", "%2")

	base = base == os.getenv("USER") and "home" or base
	return string.format("  %s ", base)
end

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

wezterm.on("format-tab-title", function(tab)
	return wezterm.format({
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format(" %s: ", tab.tab_index) },
		"ResetAttributes",
		{ Text = process_icon(tab) },
		{ Text = " " },
		{ Text = basename(tab) },
		{ Text = " |" },
	})
end)

return {
	-- Font
	font = wezterm.font_with_fallback({
		"FiraCode Nerd Font",
		"JetBrains Mono",
		"Ubuntu Nerd Font",
	}),
	font_size = 11,
	warn_about_missing_glyphs = false,

	-- Tabs
	hide_tab_bar_if_only_one_tab = true,
	show_new_tab_button_in_tab_bar = false,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 25,

	-- Updates
	show_update_window = false,
	check_for_updates = false,

	-- Other Config
	exit_behavior = "Close",
	audible_bell = "Disabled",
	automatically_reload_config = true,

	-- Theme
	colors = {
		foreground = colors.foreground,
		background = colors.background,
		split = colors.split,
		ansi = {
			colors.grey,
			colors.red,
			colors.green,
			colors.yellow,
			colors.cyan,
			colors.pink,
			colors.teal,
			colors.grey2,
		},
		brights = {
			colors.grey2,
			colors.red,
			colors.green,
			colors.yellow,
			colors.cyan,
			colors.purple,
			colors.teal,
			colors.grey,
		},
		tab_bar = {
			background = colors.black,
			active_tab = {
				bg_color = colors.background,
				fg_color = colors.foreground,
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = colors.black2,
				fg_color = colors.grey2,
			},
		},
	},
}

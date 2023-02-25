-- GitSigns
require('gitsigns').setup({
	signs = {
		add = { hl = 'GitSignsAdd', text = '│' },
		change = { hl = 'GitSignsChange', text = '│' },
		delete = { hl = 'GitSignsDelete', text = '>' },
		topdelete = { hl = 'GitSignsDelete', text = '‾' },
		changedelete = { hl = 'GitSignsChange', text = '~' },
	},
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol',
		delay = 2000,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>, <summary>',
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1,
	},
})

-- Settings
-- For more information about the options use :h 'option'.
-- E.g. :h 'background'

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Global Options
vim.opt.background = 'dark' -- Tell NVim the background color
vim.opt.backup = false -- No backup file when written
vim.opt.clipboard = 'unnamedplus' -- Copy-Paste between Neovim and everything else
vim.opt.cmdheight = 1 -- More space to display messages
vim.opt.completeopt = 'menuone,noselect' -- Set for nvim-compe. Comma-separated options for insert mode.
vim.opt.encoding = 'UTF-8' -- Encoding used internally
vim.opt.hidden = true -- Buffers becomes hidden when abandoned
vim.opt.hlsearch = false -- Highlighting search
vim.opt.laststatus = 3 -- Influence if the last window should have a statusline. 2 -> always.
vim.opt.listchars = 'tab:│ ,lead:.,trail:.,extends:>,precedes:<' -- Make tabs appear as | in the editor
vim.opt.mouse = 'a' -- Enables mouse support
vim.opt.pumheight = 10 -- Maximum number of items to show in Pop-ups
vim.opt.ruler = true -- Show line and column numbers of the cursor position
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.showmode = false -- In Insert/Replace/Visual put a message on the last line.
vim.opt.smarttab = true -- Insert "tabstop" number of spaces when pressing tab
vim.opt.splitbelow = true -- Horizontal splits will be bellow
vim.opt.splitright = true -- Vertical splits will be on the right
vim.opt.timeoutlen = 500 -- Time in miliseconds to wait for a mapped sequence to complete
vim.opt.termguicolors = true -- Set for colorizer. Enables 24Bit colors on TUI.
vim.opt.updatetime = 300 -- Time to wait before the swap file is written to disk (also CursorHold)
vim.opt.writebackup = false -- No backup file

-- Buffer Options
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.expandtab = false -- Converts tabs into spaces
vim.opt.fileencoding = 'UTF-8' -- Encoding fot the current buffer. Conversion done with iconv()
vim.opt.shiftwidth = 4 -- Change number of spaces inserted for indentation
vim.opt.smartindent = true -- Smart autoindenting when starting a new line
vim.opt.softtabstop = -1 -- Length to use when editing text (0 for 'tabstop', -1 for 'shiftwidth')
vim.opt.syntax = 'ON' -- Enable syntax
vim.opt.tabstop = 4 -- Set Tab to 4 spaces

-- Window Options
vim.opt.conceallevel = 0 -- Determine how text with the "conceal" attribute is shown. 0 -> As text
vim.opt.cursorline = true -- Enable hightlightning of the current line
vim.opt.list = true -- Always show Tabs
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative numbers
vim.opt.signcolumn = 'yes' -- Always show the SignColumn
vim.opt.wrap = false -- Display long lines as such

vim.cmd('filetype plugin indent on')

vim.cmd(':colo cosmos')

-- General Mappings
local opts = { noremap = true, silent = true }

-- Save
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>', opts)

-- Quit
vim.keymap.set('n', '<C-q>', ':q<CR>', opts)

-- Better Tabbing
vim.keymap.set('v', '<S-TAB>', '<gv', opts)
vim.keymap.set('v', '<TAB>', '>gv', opts)

-- Window Nav
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Terminal
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', opts)

-- Move Line/Block
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', { noremap = true, silent = true, nowait = true })
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', { noremap = true, silent = true, nowait = true })
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', { noremap = true, silent = true, nowait = true })
vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', { noremap = true, silent = true, nowait = true })

vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', { noremap = true, silent = true, nowait = true })
vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', { noremap = true, silent = true, nowait = true })
vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', { noremap = true, silent = true, nowait = true })
vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', { noremap = true, silent = true, nowait = true })

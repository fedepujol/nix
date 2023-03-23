-- formatter.nvim
local filetypes = require('formatter.filetypes')

require('formatter').setup({
    logging = true, -- Enable logging
    log_level = vim.log.levels.WARN, -- Log level
    filetype = { -- Formatter configurations are opt-in
        lua = {
            filetypes.lua.stylua,
        },
        markdown = {
            filetypes.markdown.prettier
        },
        rust = {
            filetypes.rust.rustfmt
        },
        yaml = {
            filetypes.yaml.yamlfmt
        }
    },
})

-- Lsp Config

-- Mappings
local key_opts = { noremap = true, silent = true }
vim.keymap.set('n', 'dl', vim.diagnostic.open_float, key_opts)
vim.keymap.set('n', 'dp', vim.diagnostic.goto_prev, key_opts)
vim.keymap.set('n', 'dn', vim.diagnostic.goto_next, key_opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, key_opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'sh', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', 'D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local border = {
	{ '╭', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '╮', 'FloatBorder' },
	{ '│', 'FloatBorder' },
	{ '╯', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '╰', 'FloatBorder' },
	{ '│', 'FloatBorder' },
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Handlers
vim.lsp.diagnostic.config = {
	virtual_text = true,
	signs = true,
	underline = true,
	update_on_insert = false,
	source = 'always',
	severity_sort = false,
	float = {
		source = 'always',
	},
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local root_pattern = require('lspconfig.util').root_pattern

-- Angular LSP
require('lspconfig').angularls.setup({
	root_dir = root_pattern({ '.angular-cli.json', 'angular.json' }),
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Bash LSP
require('lspconfig').bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- CSS LSP
require('lspconfig').cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		css = {
			validate = true,
		},
	},
})

-- Emmet LSP
require('lspconfig').emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = root_pattern({ '.git', '*.html', '*.css' }),
	filtypes = { 'html', 'css' },
})

-- HTML LSP
--Enable (broadcasting) snippet capability for completion
require('lspconfig').html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- JSON LSP
require('lspconfig').jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			validate = {
				enable = true,
			},
			schemas = {
				{
					fileMatch = { 'package.json' },
					url = 'https://json.schemastore.org/package.json'
				},
				{
					fileMatch = { 'tsconfig*.json' },
					url = 'https://json.schemastore.org/tsconfig.json'
				},
				{
					fileMatch = { 'tslint.json' },
					url = 'https://json.schemastore.org/tslint.json'
				},
				{
					fileMatch = { '.angular-cli.json' },
					url = 'https://json.schemastore.org/angular-cli.json'
				},
				{
					fileMatch = { 'angular.json' },
					url = 'https://raw.githubusercontent.com/angular/angular-cli/master/packages/angular/cli/lib/config/workspace-schema.json'
				},
				{
					fileMatch = { '.eslintrc' },
					url = 'https://json.schemastore.org/eslintrc.json'
				},
				{
					fileMatch = { '.vsconfig ' },
					url = 'https://json.schemastore.org/vsconfig.json'
				}
			}
		}
	}
})

-- Lua LSP
require('lspconfig').lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which versin of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			diagnostics = {
				-- Get the language server to recognize the 'vim' global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Marksman LSP
require('lspconfig').marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Nix LSP
require('lspconfig').nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		['nil'] = {
			formatting = {
				command = { "nixpkgs-fmt" }
			}
		}
	}
})

-- Python LSP
require('lspconfig').pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- TSServer LSP
require('lspconfig').tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Rust LSP
require('lspconfig').rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities
})

-- Vim LSP
require('lspconfig').vimls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Yaml LSP
require('lspconfig').yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.yml',
				['https://yarnpkg.com/configuration/yarnrc.json'] = '.yarnrc.yml',
				['https://json.schemastore.org/yamllint.json'] = 'yamllint',
			}
		}
	}
})

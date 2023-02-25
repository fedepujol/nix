-- neodev config
require('neodev').setup({
	library = {
		enabled = true,
		runtime = true,
		types = true,
		plugins = true
	},
	setup_jsonls = false,
	lspconfig = true,
	pathStrict = true
})

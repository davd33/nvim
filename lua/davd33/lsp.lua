vim.lsp.enable('lua_ls')
vim.lsp.enable('basedpyright')

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("basedpyright", {
    capabilities = capabilities,
})

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false, --{ current_line = true },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- HTML
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "html", "shtml", "htm" },
	callback = function()
		vim.lsp.start({
			name = "superhtml",
			cmd = { "superhtml", "lsp" },
			root_dir = vim.fs.dirname(vim.fs.find({".git"}, { upward = true })[1])
		})
	end
})

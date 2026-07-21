-- Diagnostics
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

-- Display all definitions found
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'gd', function ()
    builtin.lsp_definitions({ jump_type = "never" })
end, { desc = 'Telescope LSP Definitions' })

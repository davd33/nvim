vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('basedpyright')

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("basedpyright", {
    capabilities = capabilities,
})


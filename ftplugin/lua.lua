local capabilities = require('blink.cmp').get_lsp_capabilities() --vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('lua_ls', { capabilities=capabilities })
vim.lsp.enable('lua_ls')


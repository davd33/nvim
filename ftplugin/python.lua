local capabilities = require('blink.cmp').get_lsp_capabilities() --vim.lsp.protocol.make_client_capabilities()

-- Python
vim.lsp.config("basedpyright", { capabilities = capabilities })
vim.lsp.enable('basedpyright')


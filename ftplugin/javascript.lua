local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('ts_ls', { capabilities=capabilities })
vim.lsp.enable('ts_ls')


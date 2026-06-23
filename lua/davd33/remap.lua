vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rf", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)


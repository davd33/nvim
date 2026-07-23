-- telescope tabs
vim.keymap.set("n", "<leader>ft", ":Telescope telescope-tabs list_tabs<CR>")
vim.keymap.set("n", "<leader>tt", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")

-- files tree 
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

-- moving selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- joining line below without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Live Grep current word
vim.keymap.set("n", "<leader>lg", function()
  local current_word = vim.fn.expand("<cword>")
  require("telescope.builtin").live_grep({
    default_text = current_word,
  })
end, { desc = "Live grep word under cursor" })

-- replace the current word in the whole buffer
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- LSP
vim.keymap.set("v", "<leader>ca", ":Lspsaga code_action<CR>")
vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>")
vim.keymap.set("n", "<leader>rr", ":Lspsaga rename<CR>")
vim.keymap.set("n", "<leader>gri", ":Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<leader>gro", ":Lspsaga outgoing_calls<CR>")
vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>")

vim.keymap.set("n", "<leader>th", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>")

-- Nvim DAP
vim.keymap.set("n", "<leader>ds", ":RustDebugArgs<CR>", { desc = "Start Debugger with arguments" })
vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
vim.keymap.set("n", "<F6>", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
vim.keymap.set(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
vim.keymap.set("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
vim.keymap.set("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

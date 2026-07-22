return {
    'nvim-mini/mini.nvim',
    config = function()
        local mini_files = require('mini.files')
        vim.keymap.set("n", "<leader>ll", mini_files.open)
    end
}

return {
    'nvim-mini/mini.nvim',
    config = function()
        local MiniFiles = require('mini.files')
        vim.keymap.set("n", "<leader>lL", MiniFiles.open)
        vim.keymap.set("n", "<leader>ll", function()
            local _ = MiniFiles.close()
            or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end)
    end
}

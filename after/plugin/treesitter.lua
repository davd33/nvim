require('nvim-treesitter').install { 'rust', 'javascript', 'html', 'lua', 'python', 'java' }
require("nvim-treesitter").setup {
    highlight = {
        enable = true,
        disable = function(lang, buf) 
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    }
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'rust', 'python', 'javascript', 'lua', 'html', 'java' },
  callback = function()
    vim.treesitter.start()                                    -- highlighting
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'     -- folds
    vim.wo.foldmethod = 'expr'
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
  end,
})


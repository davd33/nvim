vim.lsp.config['rust'] = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml' },
}

vim.lsp.enable('rust')

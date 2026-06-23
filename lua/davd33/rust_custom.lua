local function cargo_run()
  local args = vim.fn.input("cargo run ")
  vim.cmd("botright 15split")

  local cmd = "cargo run"
  if args ~= "" then
    cmd = cmd .. " " .. args
  end

  vim.cmd("terminal " .. cmd)
end

vim.keymap.set("n", "<leader>r", cargo_run, { desc = "Cargo run" })

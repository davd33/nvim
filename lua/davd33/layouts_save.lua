local M = {}

local registers = {}

function M.save(register)
  local file = vim.fn.stdpath("state") .. "/layout-" .. register .. ".vim"
  vim.cmd("silent! mksession! " .. vim.fn.fnameescape(file))
  registers[register] = file
  vim.notify("Saved layout " .. register)
end

function M.restore(register)
  local file = registers[register]
  if not file or vim.fn.filereadable(file) == 0 then
    vim.notify("No layout in register " .. register, vim.log.levels.WARN)
    return
  end

  vim.cmd("silent source " .. vim.fn.fnameescape(file))
  vim.notify("Restored layout " .. register)
end

for i = 1, 9 do
  vim.keymap.set("n", "<leader>ls" .. i, function()
    M.save(i)
  end, { desc = "Save layout " .. i })

  vim.keymap.set("n", "<leader>lr" .. i, function()
    M.restore(i)
  end, { desc = "Restore layout " .. i })
end

return M

local M = {}

function M.open(dir)
  dir = vim.fn.expand(dir)
  vim.g.cf_dir = dir

  vim.cmd("edit " .. dir .. "/Program.cs")

  -- right pane: input.txt, then resize right to 40%
  vim.cmd("rightbelow vsplit " .. dir .. "/output.txt")
  vim.cmd("vertical resize 40%")

  -- split right pane for input.txt
  vim.cmd("split " .. dir .. "/input.txt")
end

return M

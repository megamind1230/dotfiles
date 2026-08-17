local M = {}

function M.open(dir, mainfile)
  dir = vim.fn.expand(dir)
  mainfile = mainfile or "Program.cs"
  vim.g.cf_dir = dir

  vim.cmd("edit " .. dir .. "/" .. mainfile)

  -- right pane: input.txt, then resize right to 40%
  vim.cmd("rightbelow vsplit " .. dir .. "/output.txt")
  vim.cmd("vertical resize 40%")

  -- split right pane for input.txt
  vim.cmd("split " .. dir .. "/input.txt")
end

return M
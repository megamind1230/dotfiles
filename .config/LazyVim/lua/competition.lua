local M = {}

function M.open(dir, mainfile)
  dir = vim.fn.expand(dir)
  mainfile = mainfile or "Program.cs"
  vim.g.cf_dir = dir

  vim.cmd("edit " .. dir .. "/" .. mainfile)
end

return M

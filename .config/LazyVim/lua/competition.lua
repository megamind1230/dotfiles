local M = {}

function M.open(dir, mainfile)
  dir = vim.fn.expand(dir)
  mainfile = mainfile or "Program.cs"
  vim.g.cf_dir = dir

  vim.cmd("edit " .. dir .. "/" .. mainfile)

  -- right pane: input.txt on top, output.txt below, 30% of the screen width
  vim.cmd("rightbelow vsplit " .. dir .. "/input.txt")
  vim.api.nvim_win_set_width(0, math.floor(vim.o.columns * 0.3))

  -- split right pane for output.txt
  vim.cmd("split " .. dir .. "/output.txt")

  -- LazyVim equalizes splits on VimResized (wincmd =), which would flatten the
  -- 30/70 layout in a real terminal. Re-apply the 30% right pane after it.
  local function apply_width()
    local w = vim.fn.win_findbuf(vim.fn.bufadd(dir .. "/input.txt"))
    if #w > 0 then
      vim.api.nvim_win_set_width(w[1], math.floor(vim.o.columns * 0.3))
    end
  end

  vim.api.nvim_create_augroup("competition_layout", { clear = true })
  vim.api.nvim_create_autocmd("VimResized", {
    group = "competition_layout",
    callback = function()
      vim.defer_fn(apply_width, 0)
    end,
  })

  -- correct once after startup settles, in case VimResized fired before the
  -- handler above was registered
  vim.defer_fn(apply_width, 100)
end

return M

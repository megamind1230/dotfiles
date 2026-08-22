local M = {}

-- Store window and buffer IDs
M.win_id = nil
M.buf_id = nil

M.create_window = function()
  local max_height = vim.api.nvim_win_get_height(0)
  local max_width = vim.api.nvim_win_get_width(0)
  local height = math.floor(max_height * 0.8)
  local width = math.floor(max_width * 0.8)

  if not (M.buf_id and vim.api.nvim_buf_is_valid(M.buf_id)) then
    M.buf_id = vim.api.nvim_create_buf(false, true)
  end

  M.win_id = vim.api.nvim_open_win(M.buf_id, true, {
    relative = "editor",
    height = height,
    width = width,
    col = math.floor((max_width - width) / 2),
    row = math.floor((max_height - height) / 2),
    style = "minimal",
    border = "rounded",
  })

  return M.win_id, M.buf_id
end

M.create_terminal = function()
  M.create_window()
  -- only spawn a job once; reuse keeps running programs alive across toggles
  local ok, chan = pcall(vim.api.nvim_buf_get_var, M.buf_id, "terminal_job_id")
  if not (ok and chan and chan > 0) then
    vim.cmd("terminal")
  end
  local cwd = vim.g.cf_dir or vim.fn.getcwd()
  -- cd only when the project changed, so a running run.sh is never interrupted
  if vim.b.term_dir ~= cwd then
    vim.fn.chansend(vim.b.terminal_job_id, "cd " .. cwd .. "\n")
    vim.b.term_dir = cwd
  end
  vim.cmd("startinsert")
end

M.is_open = function()
  return M.win_id and vim.api.nvim_win_is_valid(M.win_id)
end

M.close = function()
  if M.is_open() then
    vim.api.nvim_win_close(M.win_id, true)
    M.win_id = nil
  end
end

M.toggle = function()
  if M.is_open() then
    M.close()
  else
    M.create_terminal()
  end
end

return M

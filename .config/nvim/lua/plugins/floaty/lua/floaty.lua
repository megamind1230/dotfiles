local M = {}

-- Store window and buffer IDs
M.win_id = nil
M.buf_id = nil

M.create_window = function()
  local max_height = vim.api.nvim_win_get_height(0)
  local max_width = vim.api.nvim_win_get_width(0)
  local height = math.floor(max_height * 0.8)
  local width = math.floor(max_width * 0.8)
  
  M.buf_id = vim.api.nvim_create_buf(false, true)
  
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
  vim.cmd.term()
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

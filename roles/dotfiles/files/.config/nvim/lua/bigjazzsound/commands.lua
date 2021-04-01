local M = {}

M.git_po = function()
  local job = require('plenary.job')
  local output = {}
  job:new({
    command = 'git',
    args = { 'po' },
    on_stderr = function(_, line)
      table.insert(output, line)
    end,
    on_stdout = function(_, line)
      table.insert(output, line)
    end,
  }):sync()

  P(output)
  -- return output
end

M.terraform_validate = function()
  local job = require('plenary.job')
  local output = job:new({
    command = 'terraform',
    args = { 'validate', '-json' },
  }):sync()

  local json = vim.fn.json_decode(output)

  if json.valid == false then
    local qflist = {}
    local type = {
      error = "E",
      warning = "W",
    }
    for _, diagnostic in ipairs(json.diagnostics) do
      table.insert(qflist, {
        filename = diagnostic.range.filename,
        lnum = diagnostic.range.start.line,
        col = diagnostic.range.start.column,
        text = diagnostic.detail,
        type = type[diagnostic.severity],
      })
    end
    vim.fn.setqflist(qflist, 'r')
    print(string.format("%d errors or warnings detected", #qflist))
  else
    print("No errors or warnings detected")
    vim.fn.setqflist({}, 'r')
  end

end

M.open_win = function(text)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  local win = vim.api.nvim_open_win(bufnr, false, {
    relative = "editor",
    style = "minimal",
    width = 40,
    height = 4,
    row = height - 3,
    col = width - 3,
    anchor = "SE",
    focusable = false,
  })
  vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, text)
  vim.defer_fn(function()
    vim.api.nvim_win_close(win, false)
  end, 3000)
end

return M

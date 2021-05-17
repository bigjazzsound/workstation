-- TODO - using namespace highlighting ala hop.nvim might be a better option

-- 100 character color difference
local colorcolumn_depth = 100
local cc = function(colorcolumn)
  local cc = {}
  for i = colorcolumn, 256 do
    table.insert(cc, i)
  end
  return string.format("%s", table.concat(cc, ","))
end

-- When changing to a buffer, "highlight" the current file by changing
-- the color of the background on the right side
vim.cmd(string.format("autocmd! BufEnter * :setlocal cursorline colorcolumn=%s", cc(colorcolumn_depth)))
vim.cmd [[autocmd! BufLeave * :setlocal nocursorline colorcolumn=0]]

vim.cmd(string.format("setlocal cursorline colorcolumn=%s", cc(colorcolumn_depth)))

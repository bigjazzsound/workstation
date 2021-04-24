local home = vim.env.HOME

DEFAULT_KEYMAP = {
  noremap = true,
  silent = true
}

-- disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_node_provider   = 0
vim.g.loaded_perl_provider   = 0

vim.wo.relativenumber = true
vim.wo.number = true

vim.cmd[[ autocmd! VimResized * :wincmd = ]]

if vim.fn.exists('##TextYankPost') then
  vim.cmd[[ autocmd TextYankPost * silent! lua require('vim.highlight').on_yank() ]]
end

vim.o.syntax = 'on'
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.inccommand = 'nosplit'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.cursorline = true
vim.o.tags = 'tags'
vim.o.winblend = 5
vim.o.laststatus = 2
-- settings for search
vim.o.hlsearch = true
vim.o.incsearch = true
-- settings for tabs
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.listchars = 'tab:..,trail:-,extends:>,precedes:<,nbsp:~'
vim.o.undofile = true
vim.o.undodir = home .. '/.local/share/vim/undo'
vim.o.backupdir = home .. '/.local/share/vim/backup'
vim.o.directory = home .. '/.local/share/swap'
vim.o.shadafile = home .. '/.local/share/viminfo'
vim.o.showmatch = true
vim.o.matchtime = 3
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.g.netrw_banner = false

-- map ESC to jk
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', DEFAULT_KEYMAP)

-- split navigation
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)

-- 100 character color difference
local colorcolumn_depth = 100
local cc = function(colorcolumn)
  local cc = {}
  for i=colorcolumn,256 do table.insert(cc, i) end
  return string.format("%s", table.concat(cc, ","))
end

-- When changing to a buffer, "highlight" the current file by changing
-- the color of the background on the right side
vim.cmd(string.format("autocmd! BufEnter * :setlocal cursorline colorcolumn=%s", cc(colorcolumn_depth)))
vim.cmd [[ autocmd! BufLeave * :setlocal nocursorline colorcolumn=0 ]]

-- shortcuts with map leader
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<leader>w',  ':w <enter>',  DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>q',  ':q<enter>',   DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd <enter>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn <enter>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp <enter>', DEFAULT_KEYMAP)

-- shortcuts for cmdline mode
vim.api.nvim_set_keymap('c', '<A-b>', '<S-Left>',    { noremap = true })
vim.api.nvim_set_keymap('c', '<A-f>', '<S-Right>',   { noremap = true })
vim.api.nvim_set_keymap('c', '<c-e>', '<End>',       { noremap = true })
vim.api.nvim_set_keymap('c', '<c-a>', '<Home>',      { noremap = true })
vim.api.nvim_set_keymap('c', '<c-d>', '<Backspace>', { noremap = true })
vim.api.nvim_set_keymap('c', '<c-f>', '<Right>',     { noremap = true })
vim.api.nvim_set_keymap('c', '<c-b>', '<Left>',      { noremap = true })

-- terminal shortcuts
vim.api.nvim_set_keymap('t', 'jk', [[<C-\><C-n>]],  DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)

vim.cmd [[ command Flash :lua require('flash') ]]
require('bigjazzsound.globals')
require('plugins')

vim.cmd [[ au BufNewFile,BufRead justfile,Justfile setfiletype make ]]
vim.cmd 'colorscheme tokyonight'

-- TODO - replace with https://github.com/bfredl/nvim-luadev
vim.api.nvim_set_keymap('n', '<leader>x', '<CMD>lua R("bigjazzsound.exec").exec_line()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('v', '<leader>x', '<CMD>lua R("bigjazzsound.exec").exec_selection()<CR><ESC>', DEFAULT_KEYMAP)

vim.api.nvim_set_keymap('n', '<leader>gpo', '<CMD>lua local git_po = R("bigjazzsound.commands").git_po(); R("bigjazzsound.commands").open_win(git_po)<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>tfv', '<CMD>lua local R("bigjazzsound.commands").terraform_validate()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>jq', '<CMD>lua R("bigjazzsound.commands").query_jira()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>jo', '<CMD>lua R("bigjazzsound.commands").query_open()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>tdd', '<CMD>lua R("bigjazzsound.commands").query_todoist()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>sp', '<CMD>lua R("bigjazzsound.commands").query_spotify()<CR>', DEFAULT_KEYMAP)

if not vim.env.TMUX then
  vim.api.nvim_set_keymap('n', '<C-Space>c', '<CMD>:tabnew<CR>', DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap('n', '<C-Space>v', '<CMD>:vnew<CR>', DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap('n', '<C-Space>x', '<CMD>:new<CR>', DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap('n', '<C-Space><C-l>', '<CMD>:tabnext<CR>', DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap('n', '<C-Space><C-h>', '<CMD>:tabprevious<CR>', DEFAULT_KEYMAP)
end

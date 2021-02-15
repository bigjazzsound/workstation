local home = vim.env.HOME

DEFAULT_KEYMAP = {
  noremap = true,
  silent = true
}

if vim.fn.filereadable('/usr/local/bin/python3') then
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

-- disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_node_provider   = 0
vim.g.loaded_perl_provider   = 0

vim.wo.relativenumber = true
vim.wo.number = true

vim.cmd[[ command! Vimrc :args $MYVIMRC $HOME/.config/nvim/lua/*.lua ]]
vim.cmd[[ autocmd! VimResized * :wincmd = ]]

if vim.fn.exists('##TextYankPost') then
  vim.cmd[[ autocmd TextYankPost * silent! lua require('vim.highlight').on_yank('IncSearch', '250') ]]
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
vim.o.undodir = home .. '/.local/share'
vim.o.backupdir = home .. '/.local/share'
vim.o.directory = home .. '/.local/share'
vim.o.shadafile = home .. '/.local/share/viminfo'
vim.o.showmatch = true
vim.o.matchtime = 3
vim.o.ignorecase = true

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
vim.api.nvim_set_keymap('n', '<leader>/',  ':nohls <enter>',   DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>w',  ':w <enter>',       DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>q',  ':q<enter>',        DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd <enter>',      DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn <enter>',      DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp <enter>',      DEFAULT_KEYMAP)

-- shortcuts for cmdline mode
vim.api.nvim_set_keymap('c', '<A-b>', '<S-Left>',    { noremap = true })
vim.api.nvim_set_keymap('c', '<A-f>', '<S-Right>',   { noremap = true })
vim.api.nvim_set_keymap('c', '<c-e>', '<End>',       { noremap = true })
vim.api.nvim_set_keymap('c', '<c-a>', '<Home>',      { noremap = true })
vim.api.nvim_set_keymap('c', '<c-d>', '<Backspace>', { noremap = true })
vim.api.nvim_set_keymap('c', '<c-f>', '<Right>',     { noremap = true })
vim.api.nvim_set_keymap('c', '<c-b>', '<Left>',      { noremap = true })

-- terminal shortcuts
vim.api.nvim_set_keymap('t', 'jk', [[<C-\><C-n>]], DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)

vim.cmd [[ au TermOpen * setlocal nonumber norelativenumber ]]

vim.cmd [[ command Flash :lua require('flash') ]]
require('plugins')

vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]
vim.o.signcolumn = "yes"
vim.cmd [[ colorscheme onedark ]]

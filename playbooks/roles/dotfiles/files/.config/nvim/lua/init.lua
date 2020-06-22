api     = vim.api
env     = vim.env
fn      = vim.fn
vim_cmd = vim.api.nvim_command
home    = env["HOME"]

set_option = api.nvim_set_option
set_keymap = api.nvim_set_keymap

DEFAULT_KEYMAP = {
  noremap = true,
  silent = true
}

if fn.filereadable('/usr/local/bin/python3') then
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

-- disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_node_provider   = 0
vim.g.loaded_perl_provider   = 0

api.nvim_win_set_option(0, 'relativenumber', true)
api.nvim_win_set_option(0, 'number', true)

vim_cmd("command! Vimrc :args $MYVIMRC $HOME/.config/nvim/lua/*.lua")
vim_cmd("autocmd! VimResized * :wincmd =")
-- I've had some weird errors with cursorline not being set for certain filetypes and when I am
-- using multiple windows, buffers, etc. So, I will just explicitly turn it on for all filetypes.
vim_cmd("autocmd! Filetype * :set cursorline")

if fn.exists('##TextYankPost') then
  vim_cmd[[autocmd TextYankPost * silent! lua require('vim.highlight').on_yank('IncSearch', '250')]]
end

local OPTIONS = {
  syntax        = 'on',
  termguicolors = true,
  inccommand    = 'nosplit',
  splitbelow    = true,
  splitright    = true,
  cursorline    = true,
  tags          = 'tags',
  winblend      = 5,
  laststatus    = 2,
  -- settings for search
  hlsearch      = true,
  incsearch     = true,
  -- settings for tabs
  expandtab     = true,
  autoindent    = true,
  smarttab      = true,
  listchars     = 'tab:..,trail:-,extends:>,precedes:<,nbsp:~',
  signcolumn    = "yes",
  undofile      = false,
  undodir       = home .. '/.local/vim/undo/',
  backupdir     = home .. '/.local/vim/backup/',
  directory     = home .. '/.local/vim/swp/',
  shadafile     = home .. '/.local/vim/viminfo',
}

for key, value in pairs(OPTIONS) do set_option(key, value) end

-- map ESC to jk
set_keymap('i', 'jk', '<Esc>', DEFAULT_KEYMAP)

-- split navigation
set_keymap('n', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
set_keymap('n', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
set_keymap('n', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
set_keymap('n', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)

-- 80 character color difference
api.nvim_win_set_option(0, 'colorcolumn', '100')
vim_cmd('highlight ColorColumn ctermbg=DarkBlue')

-- shortcuts with map leader
vim.g.mapleader = " "
set_keymap('n', '<leader>/',  ':nohls <enter>',   DEFAULT_KEYMAP)
set_keymap('n', '<leader>w',  ':w <enter>',       DEFAULT_KEYMAP)
set_keymap('n', '<leader>q',  ':q<enter>',        DEFAULT_KEYMAP)
set_keymap('n', '<leader>bl', ':Buffers <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bd', ':bd <enter>',      DEFAULT_KEYMAP)
set_keymap('n', '<leader>bn', ':bn <enter>',      DEFAULT_KEYMAP)
set_keymap('n', '<leader>bp', ':bp <enter>',      DEFAULT_KEYMAP)

-- shortcuts for cmdline mode
set_keymap('c', '<A-b>', '<S-Left>',    { noremap = true })
set_keymap('c', '<A-e>', '<S-Right>',   { noremap = true })
set_keymap('c', '<c-e>', '<End>',       { noremap = true })
set_keymap('c', '<c-a>', '<Home>',      { noremap = true })
set_keymap('c', '<c-d>', '<Backspace>', { noremap = true })

-- terminal shortcuts
set_keymap('t', 'jk', [[<C-\><C-n>]], DEFAULT_KEYMAP)
set_keymap('t', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
set_keymap('t', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
set_keymap('t', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
set_keymap('t', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)
vim_cmd[[au TermOpen * setlocal nonumber norelativenumber]]

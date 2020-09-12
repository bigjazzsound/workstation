api     = vim.api
env     = vim.env
home    = env["HOME"]

set_keymap = api.nvim_set_keymap

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

vim.cmd("command! Vimrc :args $MYVIMRC $HOME/.config/nvim/lua/*.lua")
vim.cmd("autocmd! VimResized * :wincmd =")
-- I've had some weird errors with cursorline not being set for certain filetypes and when I am
-- using multiple windows, buffers, etc. So, I will just explicitly turn it on for all filetypes.
vim.cmd("autocmd! Filetype * :set cursorline")

if vim.fn.exists('##TextYankPost') then
  vim.cmd[[autocmd TextYankPost * silent! lua require('vim.highlight').on_yank('IncSearch', '250')]]
end

vim.o.syntax = 'on'
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
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.undodir = home .. '/.local/share'
vim.o.backupdir = home .. '/.local/share'
vim.o.directory = home .. '/.local/share'
vim.o.shadafile = home .. '/.local/share/viminfo'
vim.o.showmatch = true
vim.o.matchtime = 3

-- map ESC to jk
set_keymap('i', 'jk', '<Esc>', DEFAULT_KEYMAP)

-- split navigation
set_keymap('n', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
set_keymap('n', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
set_keymap('n', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
set_keymap('n', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)

-- 80 character color difference
vim.wo.colorcolumn = '100'
vim.cmd('highlight ColorColumn ctermbg=DarkBlue')

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
vim.cmd[[au TermOpen * setlocal nonumber norelativenumber]]

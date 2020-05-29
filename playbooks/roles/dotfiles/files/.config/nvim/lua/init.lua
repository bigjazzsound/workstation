local api = vim.api
local home = os.getenv("HOME")
local set_option = api.nvim_set_option
local set_keymap = api.nvim_set_keymap

-- disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_node_provider   = 0
vim.g.loaded_perl_provider   = 0

api.nvim_win_set_option(0, 'number', true)

-- api.nvim_command("command! Vimrc :edit $MYVIMRC")
api.nvim_command("command! Vimrc :edit $MYVIMRC")
api.nvim_command("autocmd! VimResized * :wincmd =")
-- I've had some weird errors with cursorline not being set for certain filetypes and when I am
-- using multiple windows, buffers, etc. So, I will just explicitly turn it on for all filetypes.
api.nvim_command("autocmd! Filetype * :set cursorline")

local DEFAULT_KEYMAP = {
  noremap = true,
  silent = true
}

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
  statusline    = '[%n] %f%h%w%m%r %{fugitive#head()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P ',
  -- statusline    = '[%n] %f%h%w%m%r %{fugitive#head()} %{StatusDiagnostic()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P ',
  -- settings for search
  hlsearch      = true,
  incsearch     = true,
  -- settings for tabs
  expandtab     = true,
  autoindent    = true,
  smarttab      = true,
  listchars     = 'tab:..,trail:-,extends:>,precedes:<,nbsp:~',
  signcolumn    = "yes",
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
api.nvim_command('highlight ColorColumn ctermbg=DarkBlue')

-- shortcuts with map leader
api.nvim_command('let mapleader=" "')
set_keymap('n', '<leader>/', ':nohls <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>w', ':w <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bl', ':Buffers <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bd', ':bd <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bn', ':bn <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bp', ':bp <enter>', DEFAULT_KEYMAP)

-- shortucts for cmdline mode
set_keymap('c', '<A-b>', '<S-Left>',    { noremap = true })
set_keymap('c', '<A-e>', '<S-Right>',   { noremap = true })
set_keymap('c', '<c-e>', '<End>',       { noremap = true })
set_keymap('c', '<c-a>', '<Home>',      { noremap = true })
set_keymap('c', '<c-d>', '<Backspace>', { noremap = true })

-- Plugins
local autoload_plug_path = api.nvim_eval("stdpath('data')") .. '/site/autoload/plug.vim'
local plug_file = io.open(autoload_plug_path , "r")
if plug_file == nil then
  os.execute('curl -fLso ' .. autoload_plug_path .. ' --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"')
  os.exit()
else
  local plugins = [[
'cespare/vim-toml'
'christoomey/vim-tmux-navigator'
'editorconfig/editorconfig-vim'
'enricobacis/paste.vim'
'Glench/Vim-Jinja2-Syntax'
'hashivim/vim-terraform', { 'for': 'terraform' }
'herrbischoff/cobalt2.vim'
'junegunn/fzf'
'junegunn/fzf.vim'
'junegunn/goyo.vim', { 'for': 'markdown' }
'junegunn/vim-easy-align'
'justinmk/vim-dirvish'
'justinmk/vim-sneak'
'martinda/Jenkinsfile-vim-syntax'
'mhartington/oceanic-next'
'mhinz/vim-signify'
'neovim/nvim-lsp'
'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
'PProvost/vim-ps1', { 'for': 'ps1' }
'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
'stephpy/vim-yaml', { 'for': 'yaml' }
'tbastos/vim-lua', { 'for': 'lua' }
'tpope/vim-commentary'
'tpope/vim-dispatch'
'tpope/vim-fugitive'
'tpope/vim-repeat'
'tpope/vim-surround'
'z0mbix/vim-shfmt', { 'for': ['sh', 'zsh'] }
]]
  vim.fn["plug#begin"](home .. "/.vim/plugged")
  for _, value in ipairs(vim.split(vim.trim(plugins), "\n")) do
    api.nvim_command("Plug " .. value)
  end
  vim.fn["plug#end"]()
end

api.nvim_command('colorscheme OceanicNext')

-- deoplete settings
vim.g['deoplete#enable_at_startup'] = 1

-- vim-signify settings
vim.g.signify_sign_change = '~'

-- vim-sneak
vim.g['sneak#label'] = 1

-- fugitive git bindings
set_keymap('n', '<leader>ga',  ':Git add %:p<CR><CR>',            DEFAULT_KEYMAP)
set_keymap('n', '<leader>gs',  ':Gstatus<CR>',                    DEFAULT_KEYMAP)
set_keymap('n', '<leader>gc',  ':Gcommit -v -q<CR>',              DEFAULT_KEYMAP)
set_keymap('n', '<leader>gt',  ':Gcommit -v -q %:p<CR>',          DEFAULT_KEYMAP)
set_keymap('n', '<leader>gd',  ':Gdiff<CR>',                      DEFAULT_KEYMAP)
set_keymap('n', '<leader>ge',  ':Gedit<CR>',                      DEFAULT_KEYMAP)
set_keymap('n', '<leader>gr',  ':Gread<CR>',                      DEFAULT_KEYMAP)
set_keymap('n', '<leader>gw',  ':Gwrite<CR><CR>',                 DEFAULT_KEYMAP)
set_keymap('n', '<leader>gl',  ':silent! Glog<CR>:bot copen<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gp',  ':Ggrep<Space>',                   DEFAULT_KEYMAP)
set_keymap('n', '<leader>gm',  ':Gmove<Space>',                   DEFAULT_KEYMAP)
set_keymap('n', '<leader>gb',  ':Gblame!<CR>',                    DEFAULT_KEYMAP)
set_keymap('n', '<leader>go',  ':Git checkout<Space>',            DEFAULT_KEYMAP)
set_keymap('n', '<leader>gps', ':Dispatch! git push<CR>',         DEFAULT_KEYMAP)
set_keymap('n', '<leader>gpl', ':Dispatch! git pull<CR>',         DEFAULT_KEYMAP)

-- editorconfig
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.\\*' }

-- dispatch settings
set_keymap('n', '<F3>', ':Dispatch<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<F4>', ':Start<CR>', DEFAULT_KEYMAP)

-- FZF
set_keymap('n', '<C-p>',     ':FZF<enter>',      DEFAULT_KEYMAP)
set_keymap('n', '<leader>f', ':FZF <enter>',     DEFAULT_KEYMAP)
set_keymap('n', '<leader>r', ':Rg <enter>',      DEFAULT_KEYMAP)
set_keymap('n', '<leader>b', ':Buffers <enter>', DEFAULT_KEYMAP)
api.nvim_command("autocmd! FileType fzf set noshowmode noruler nonu signcolumn=no")
api.nvim_command("let $FZF_DEFAULT_OPTS .= ' --layout=reverse -m --border'")
vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.6
  }
}

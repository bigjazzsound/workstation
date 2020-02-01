local api = vim.api
local home = os.getenv("HOME")
local DEFAULT_KEYMAP = { noremap = true, silent = true }
local set_option = api.nvim_set_option
local set_keymap = api.nvim_set_keymap

-- disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.python3_host_prog = '/usr/bin/python3'

api.nvim_win_set_option(0, 'number', true)

api.nvim_command("command! Vimrc :edit $MYVIMRC")
api.nvim_command("autocmd! VimResized * :wincmd =")

options = {
  syntax        = 'on',
  termguicolors = true,
  inccommand    = 'nosplit',
  splitbelow    = true,
  splitright    = true,
  cursorline    = true,
  tags          = 'tags',
  winblend      = 5,
  laststatus    = 2,
  -- statusline    = '[%n] %f%h%w%m%r  %{fugitive#head()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P ',
  statusline    = '[%n] %f%h%w%m%r  %{fugitive#head()} %{StatusDiagnostic()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P ',
  -- settings for search
  hlsearch      = true,
  incsearch     = true,
  -- settings for tabs
  expandtab     = true,
  autoindent    = true,
  smarttab      = true,
  listchars     = 'tab:..,trail:-,extends:>,precedes:<,nbsp:~',
}

for key, value in pairs(options) do set_option(key, value) end

-- map ESC to jk
set_keymap('i', 'jk', '<Esc>', DEFAULT_KEYMAP)

-- split navigation
set_keymap('n', '<C-J>', '<C-W><C-J>', DEFAULT_KEYMAP)
set_keymap('n', '<C-K>', '<C-W><C-K>', DEFAULT_KEYMAP)
set_keymap('n', '<C-L>', '<C-W><C-L>', DEFAULT_KEYMAP)
set_keymap('n', '<C-H>', '<C-W><C-H>', DEFAULT_KEYMAP)

-- 80 character color difference
api.nvim_win_set_option(0, 'colorcolumn', '80')
api.nvim_command('highlight ColorColumn ctermbg=DarkBlue')

-- shortcuts with map leader
api.nvim_command('let mapleader=" "')
set_keymap('n', '<leader>/', ':nohls <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>w', ':w <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bd', ':bd <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bn', ':bn <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>bp', ':bp <enter>', DEFAULT_KEYMAP)

-- shortucts for cmdline mode
set_keymap('c', '<A-b>', '<S-Left>', { noremap = true })
set_keymap('c', '<A-e>', '<S-Right>', { noremap = true })
set_keymap('c', '<c-e>', '<End>', { noremap = true })
set_keymap('c', '<c-a>', '<Home>', { noremap = true })
set_keymap('c', '%%', [[<C-R>=expand('%:h').'/'<CR>]], { noremap = true })

-- Plugins
local autoload_plug_path = api.nvim_eval("stdpath('data')") .. '/site/autoload/plug.vim'
local plug_file = io.open(autoload_plug_path , "r")
if plug_file == nil then
  os.execute('curl -fLso ' .. autoload_plug_path .. ' --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"')
  os.exit()
else
  local plugins = [[
'christoomey/vim-tmux-navigator'
'editorconfig/editorconfig-vim'
'enricobacis/paste.vim'
'hashivim/vim-terraform', { 'for': 'terraform' }
'herrbischoff/cobalt2.vim'
'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown' }
'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
'junegunn/fzf.vim'
'junegunn/goyo.vim', { 'for': 'markdown' }
'junegunn/vim-easy-align'
'justinmk/vim-dirvish'
'justinmk/vim-sneak'
'mhartington/oceanic-next'
'mhinz/vim-signify'
'mhinz/vim-startify'
'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
'pearofducks/ansible-vim', { 'for': 'yaml' }
'stephpy/vim-yaml', { 'for': 'yaml' }
'tbastos/vim-lua', { 'for': 'lua' }
'tpope/vim-commentary'
'tpope/vim-dispatch'
'tpope/vim-eunuch'
'tpope/vim-fugitive'
'tpope/vim-obsession'
'tpope/vim-repeat'
'tpope/vim-surround'
]]
  vim.fn["plug#begin"](home .. "/.vim/plugged")
  for _, value in ipairs(vim.split(vim.trim(plugins), "\n")) do
    api.nvim_command("Plug " .. value)
  end
  vim.fn["plug#end"]()
end

api.nvim_command('colorscheme OceanicNext')

-- vim-signify settings
vim.g.signify_sign_change = '~'

-- vim-sneak
vim.g['sneak#label'] = 1

-- fugitive git bindings
set_keymap('n', '<leader>ga', ':Git add %:p<CR><CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gs', ':Gstatus<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gc', ':Gcommit -v -q<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gt', ':Gcommit -v -q %:p<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gd', ':Gdiff<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>ge', ':Gedit<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gr', ':Gread<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gw', ':Gwrite<CR><CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gl', ':silent! Glog<CR>:bot copen<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gp', ':Ggrep<Space>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gm', ':Gmove<Space>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gb', ':Gblame!<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>go', ':Git checkout<Space>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gps', ':Dispatch! git push<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>gpl', ':Dispatch! git pull<CR>', DEFAULT_KEYMAP)

-- editorconfig
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.\\*' }

-- dispatch settings
set_keymap('n', '<F3>', ':Dispatch<CR>', DEFAULT_KEYMAP)
set_keymap('n', '<F4>', ':Start<CR>', DEFAULT_KEYMAP)

-- FZF
set_keymap('n', '<C-p>', ':FZF<cr>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>f', ':FZF <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>r', ':Rg <enter>', DEFAULT_KEYMAP)
set_keymap('n', '<leader>b', ':Buffers <enter>', DEFAULT_KEYMAP)

-- Terminal buffer options for fzf
api.nvim_command("autocmd! FileType fzf set noshowmode noruler nonu signcolumn=no")
api.nvim_command("let $FZF_DEFAULT_OPTS .= ' --layout=reverse -m --border'")

function NavigationFloatingWin()
  -- get the editor's max width and height
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- create a new, scratch buffer, for fzf
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  -- if the editor is big enough
  if (width > 150 or height > 35) then
    -- fzf's window height is 3/4 of the max height, but not more than 30
    local win_height = math.min(math.ceil(height * 3 / 4), 30)
    local win_width

    -- if the width is small
    if (width < 150) then
      -- just subtract 8 from the editor's width
      win_width = math.ceil(width - 8)
    else
      -- use 90% of the editor's width
      win_width = math.ceil(width * 0.9)
    end

    -- settings for the fzf window
    local opts = {
      relative = "editor",
      width = win_width,
      height = win_height,
      row = math.ceil((height - win_height) / 2),
      col = math.ceil((width - win_width) / 2)
    }

    -- create a new floating window, centered in the editor
    local win = vim.api.nvim_open_win(buf, true, opts)
  end
end

vim.g.fzf_layout = { window = 'lua NavigationFloatingWin()' }

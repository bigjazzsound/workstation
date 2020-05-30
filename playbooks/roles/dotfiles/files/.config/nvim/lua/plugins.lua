local api = vim.api
local home = os.getenv("HOME")
local set_keymap = api.nvim_set_keymap
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
'Shougo/deoplete-lsp',
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

local autoload_plug_path = api.nvim_eval("stdpath('data')") .. '/site/autoload/plug.vim'
local plug_file = io.open(autoload_plug_path , "r")
if plug_file == nil then
  os.execute('curl -fLso ' .. autoload_plug_path .. ' --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"')
  os.execute([[nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"]])
else
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

vim.call(
  "setenv",
  "FZF_DEFAULT_OPTS",
  '--layout=reverse -m --preview="bat --color=always --style plain --theme base16 {}"'
)

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.8,
  }
}

api.nvim_set_option(
  'statusline',
  '[%n] %f%h%w%m%r %{fugitive#head()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P '
)

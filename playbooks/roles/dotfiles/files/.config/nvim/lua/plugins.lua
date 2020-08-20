local plugins = [[
'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
'PProvost/vim-ps1', { 'for': 'ps1' }
'Yggdroot/indentLine', { 'for': 'yaml' }
'cespare/vim-toml', { 'for': 'toml' }
'christoomey/vim-tmux-navigator'
'danilamihailov/beacon.nvim'
'editorconfig/editorconfig-vim'
'enricobacis/paste.vim'
'haorenW1025/completion-nvim'
'hardcoreplayers/oceanic-material'
'hashivim/vim-terraform', { 'for': 'terraform' }
'herrbischoff/cobalt2.vim'
'hkupty/nvimux'
'junegunn/fzf'
'junegunn/fzf.vim'
'junegunn/goyo.vim'
'junegunn/vim-easy-align'
'junegunn/vim-plug'
'justinmk/vim-dirvish'
'justinmk/vim-sneak'
'kassio/neoterm'
'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }
'mbbill/undotree'
'mhartington/oceanic-next'
'mhinz/vim-signify'
'neovim/nvim-lsp'
'nvim-treesitter/nvim-treesitter'
'rbong/vim-flog'
'stephpy/vim-yaml', { 'for': 'yaml' }
'tbastos/vim-lua', { 'for': 'lua' }
'tpope/vim-commentary'
'tpope/vim-dispatch'
'tpope/vim-eunuch'
'tpope/vim-fugitive'
'tpope/vim-repeat'
'tpope/vim-surround'
'z0mbix/vim-shfmt', { 'for': ['sh', 'zsh'] }
]]

local autoload_plug_path = api.nvim_eval("stdpath('data')") .. '/site/autoload/plug.vim'
local plug_file = io.open(autoload_plug_path , "r")
if plug_file == nil then
  os.execute('curl -fLso ' .. autoload_plug_path .. ' --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"')
  vim_cmd[[qall]]
else
  fn["plug#begin"](home .. "/.local/vim/plugged")
  for _, value in ipairs(vim.split(vim.trim(plugins), "\n")) do
    vim_cmd("Plug " .. value)
  end
  fn["plug#end"]()
  for _, values in pairs(vim.g.plugs) do
    if fn.isdirectory(values.dir) == 0 then
      vim_cmd[[PlugInstall --sync]]
    end
  end
end

-- vim_cmd('colorscheme OceanicNext')
vim_cmd('colorscheme oceanic_material')

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

-- hardtime
vim.g.hardtime_default_on = 1

-- oceanic material
vim.g.oceanic_material_allow_bold = 1
vim.g.oceanic_material_allow_italic = 1
vim.g.oceanic_material_allow_underline = 1
vim.g.oceanic_material_transparent_background = 1

-- FZF
set_keymap('n', '<C-p>',     ':FZF<enter>',      DEFAULT_KEYMAP)
set_keymap('n', '<leader>f', ':FZF <enter>',     DEFAULT_KEYMAP)
set_keymap('n', '<leader>r', ':Rg <enter>',      DEFAULT_KEYMAP)
set_keymap('n', '<leader>b', ':Buffers <enter>', DEFAULT_KEYMAP)

env["BAT_THEME"] = "Dracula"
env["FZF_DEFAULT_OPTS"] = [[--layout=reverse -m --preview="bat --color=always --style plain {}"]]
env["FZF_DEFAULT_COMMAND"] = "fd --type f"

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.8,
    border = 'sharp',
  }
}

set_option(
  'statusline',
  '[%n] %f%h%w%m%r %{fugitive#head()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P '
)

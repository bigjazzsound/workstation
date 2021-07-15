local home = vim.loop.os_homedir()

DEFAULT_KEYMAP = {
  noremap = true,
  silent = true,
}

-- disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

require "bigjazzsound.globals"
require "plugins"

vim.cmd [[autocmd! VimResized * :wincmd =]]

if vim.fn.exists "##TextYankPost" then
  vim.cmd [[autocmd TextYankPost * silent! lua require('vim.highlight').on_yank()]]
end

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.syntax = "on"
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.inccommand = "nosplit"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.tags = "tags"
vim.opt.winblend = 5
vim.opt.laststatus = 2
-- settings for search
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- settings for tabs
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.listchars = {
  tab = "..",
  trail = "-",
  extends = ">",
  precedes = "<",
  nbsp = "~",
}

local create_dir = function(dir)
  local path = require("plenary.path"):new(dir)
  if not path:exists() then
    path:mkdir { parents = true, mode = 0755 }
  end
  return dir
end

vim.opt.undofile = true
vim.opt.undodir = create_dir(home .. "/.local/share/nvim/undo")
vim.opt.backupdir = create_dir(home .. "/.local/share/nvim/backup")
vim.opt.directory = create_dir(home .. "/.local/share/nvim/swap")
vim.opt.shadafile = home .. "/.local/share/viminfo"
vim.opt.showmatch = true
vim.opt.matchtime = 3
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.updatetime = 650
vim.g.netrw_banner = false

-- map ESC to jk
vim.api.nvim_set_keymap("i", "jk", "<Esc>", DEFAULT_KEYMAP)

-- split navigation
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", DEFAULT_KEYMAP)

vim.cmd [[command Focus :lua require('bigjazzsound.focus')]]

-- shortcuts with map leader
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>w", ":w <enter>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>q", ":q<enter>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>bd", ":bd <enter>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>bn", ":bn <enter>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>bp", ":bp <enter>", DEFAULT_KEYMAP)

-- shortcuts for cmdline mode
vim.api.nvim_set_keymap("c", "<A-b>", "<S-Left>", { noremap = true })
vim.api.nvim_set_keymap("c", "<A-f>", "<S-Right>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-e>", "<End>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-a>", "<Home>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-d>", "<Backspace>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-f>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-b>", "<Left>", { noremap = true })

-- terminal shortcuts
vim.api.nvim_set_keymap("t", "jk", [[<C-\><C-n>]], DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("t", "<C-J>", "<C-W><C-J>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("t", "<C-K>", "<C-W><C-K>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("t", "<C-L>", "<C-W><C-L>", DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("t", "<C-H>", "<C-W><C-H>", DEFAULT_KEYMAP)

vim.cmd [[command Flash <CMD>lua require('flash')<CR>]]

vim.cmd "au BufNewFile,BufRead justfile,Justfile set filetype=make"
vim.cmd "au BufNewFile,BufRead *.fish set filetype=fish"
vim.cmd "au BufNewFile,BufRead */.aws/config set filetype=dosini"

local ok, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not ok then
  vim.cmd "colorscheme default"
end

-- TODO - The refresh might need to be schedled to wait for the push
vim.api.nvim_set_keymap(
  "n",
  "<leader>gpo",
  '<CMD>lua local git_po = R("bigjazzsound.commands").git_po(); R("bigjazzsound.commands").open_win(git_po); require("neogit.status")<CR>',
  DEFAULT_KEYMAP
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>tfv",
  '<CMD>lua R("bigjazzsound.commands").terraform_validate()<CR>',
  DEFAULT_KEYMAP
)
vim.api.nvim_set_keymap("n", "<leader>jq", '<CMD>lua R("bigjazzsound.commands").query_jira()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>jo", '<CMD>lua R("bigjazzsound.commands").query_open()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>tdd", '<CMD>lua R("bigjazzsound.commands").query_todoist()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>sp", '<CMD>lua R("bigjazzsound.commands").query_spotify()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap("n", "<leader>ad", '<CMD>lua R("bigjazzsound.commands").ansible_doc()<CR>', DEFAULT_KEYMAP)

if not vim.env.TMUX then
  vim.api.nvim_set_keymap("n", "<C-Space>c", "<CMD>:tabnew<CR>", DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap("n", "<C-Space>v", "<CMD>:vnew<CR>", DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap("n", "<C-Space>x", "<CMD>:new<CR>", DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap("n", "<C-Space><C-l>", "<CMD>:tabnext<CR>", DEFAULT_KEYMAP)
  vim.api.nvim_set_keymap("n", "<C-Space><C-h>", "<CMD>:tabprevious<CR>", DEFAULT_KEYMAP)
end

vim.api.nvim_set_keymap("n", "<leader>ps", '<CMD>lua require("packer").sync()<CR>', DEFAULT_KEYMAP)

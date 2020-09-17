-- Shamelessly stolen from
-- https://raw.githubusercontent.com/tjdevries/config_manager/master/xdg_config/nvim/lua/plugins.lua
-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  vim.cmd [[ qall ]]

  return
end

local fugitive_settings = function()
  vim.o.statusline = '[%n] %f%h%w%m%r %{fugitive#head()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft}  %l/%L  %P '
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
  set_keymap('n', '<leader>gps',':Dispatch! Git push<CR>', DEFAULT_KEYMAP)
  set_keymap('n', '<leader>gpl',':Dispatch! Git pull<CR>', DEFAULT_KEYMAP)
end

return require('packer').startup(function()

  use {
    'wbthomason/packer.nvim',
    opt = true,
  }

  -- Plugins without any special configuration
  use {
    'Yggdroot/indentLine',
    'christoomey/vim-tmux-navigator',
    'danilamihailov/beacon.nvim',
    'enricobacis/paste.vim',
    'euclidianAce/BetterLua.vim',
    'herrbischoff/cobalt2.vim',
    'junegunn/fzf',
    'junegunn/goyo.vim',
    'junegunn/vim-easy-align',
    'junegunn/vim-plug',
    'mbbill/undotree',
    'mhartington/oceanic-next',
    'nvim-lua/completion-nvim',
    'psliwka/vim-smoothie',
    'tjdevries/nlua.nvim',
    'tpope/vim-commentary',
    'tpope/vim-dispatch',
    'tpope/vim-eunuch',
    'tpope/vim-repeat',
    'tpope/vim-surround',
  }

  use {
    'Glench/Vim-Jinja2-Syntax',
    ft = { 'jinja' },
  }

  use {
    'PProvost/vim-ps1',
    ft = { 'ps1' },
  }

  use {
    'cespare/vim-toml',
    ft = { 'toml' },
  }

  use {
    'editorconfig/editorconfig-vim',
    config = function()
      vim.g.EditorConfig_exclude_patterns = { 'fugitive://.\\*' }
    end
  }

  use {
    'hardcoreplayers/oceanic-material',
    config = function()
      vim.g.oceanic_material_allow_bold = 1
      vim.g.oceanic_material_allow_italic = 1
      vim.g.oceanic_material_allow_underline = 1
      vim.g.oceanic_material_transparent_background = 1
    end
  }

  use {
    'hashivim/vim-terraform',
    ft = { 'terraform', 'tf' },
  }

  use {
    'hkupty/nvimux',
    config = function()
      local nvimux = require('nvimux')

      nvimux.config.set_all{
        prefix = '<C-Space>',
        new_window = 'enew', -- Use 'term' if you want to open a new term for every new window
        new_tab = nil, -- Defaults to new_window. Set to 'term' if you want a new term for every new tab
        new_window_buffer = 'single',
        quickterm_direction = 'botright',
        quickterm_orientation = 'vertical',
        quickterm_scope = 't', -- Use 'g' for global quickterm
        quickterm_size = '80',
      }

      nvimux.bindings.bind_all{
        {'x', ':belowright Tnew', {'n', 'v', 'i', 't'}},
        {'v', ':vertical Tnew', {'n', 'v', 'i', 't'}},
        {'<C-l>', 'gt', {'n', 'v', 'i', 't'}},
        {'<C-h>', 'gT', {'n', 'v', 'i', 't'}},
        {'c', ':tab Tnew', {'n', 'v', 'i', 't'}},
      }

      nvimux.bootstrap()
    end
  }

  use {
    'junegunn/fzf.vim',
    config = function()
      set_keymap('n', '<C-p>',     ':FZF<enter>',  DEFAULT_KEYMAP)
      set_keymap('n', '<leader>f', ':FZF <enter>', DEFAULT_KEYMAP)
      set_keymap('n', '<leader>r', ':Rg <enter>',  DEFAULT_KEYMAP)

      vim.env.BAT_THEME = "Dracula"
      vim.env.FZF_DEFAULT_OPTS = [[--layout=reverse -m --preview="bat --color=always --style plain {}"]]
      vim.env.FZF_DEFAULT_COMMAND = "fd --type f"

      vim.g.fzf_layout = {
        window = {
          width = 0.9,
          height = 0.8,
          border = 'sharp',
        }
      }
    end
  }

  use {
    'justinmk/vim-dirvish',
    cmd = {
      'Dirvish',
    }
  }

  use {
    'justinmk/vim-sneak',
    config = "vim.g['sneak#label'] = 1"
  }

  use {
    'kassio/neoterm',
    config = function()
      vim.g.neoterm_autoinsert = 1
      vim.g.neoterm_clear_cmd = { "clear", "" }
      vim.g.neoterm_default_mod = "vertical"
    end
  }

  use {
    'martinda/Jenkinsfile-vim-syntax',
    ft = { 'Jenkinsfile' },
  }

  use {
    'mhinz/vim-signify',
    config = [[ vim.g.signify_sign_change = '~' ]],
  }

  use {
    'morhetz/gruvbox',
    vim.cmd('colorscheme gruvbox'),
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('nvim_lsp').bashls.setup{
        on_attach = require('completion').on_attach,
        filetypes = {
          "sh",
          "zsh",
        }
      }
      require('nvim_lsp').dockerls.setup{on_attach=require('completion').on_attach}
      require('nvim_lsp').gopls.setup{on_attach=require('completion').on_attach}
      require('nvim_lsp').jsonls.setup{on_attach=require('completion').on_attach}
      require('nvim_lsp').pyls.setup{on_attach=require('completion').on_attach}
      require('nlua.lsp.nvim').setup(require('nvim_lsp'), {
        on_attach = require('completion').on_attach,

        globals = {
          "home",
          "set_keymap",
          "use"
        }
      })
      require('nvim_lsp').vimls.setup{on_attach=require('completion').on_attach}
      require('nvim_lsp').yamlls.setup{on_attach=require('completion').on_attach}

      vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
      vim.cmd [[ autocmd BufEnter * lua require('completion').on_attach() ]]
      vim.o.completeopt = "menuone,noinsert,noselect"

      set_keymap('n', 'gd',    ':lua vim.lsp.buf.declaration()<CR>',     DEFAULT_KEYMAP)
      set_keymap('n', '<c-]>', ':lua vim.lsp.buf.definition()<CR>',      DEFAULT_KEYMAP)
      set_keymap('n', 'K',     ':lua vim.lsp.buf.hover()<CR>',           DEFAULT_KEYMAP)
      set_keymap('n', 'gD',    ':lua vim.lsp.buf.implementation()<CR>',  DEFAULT_KEYMAP)
      set_keymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>',  DEFAULT_KEYMAP)
      set_keymap('n', '1gD',   ':lua vim.lsp.buf.type_definition()<CR>', DEFAULT_KEYMAP)
      set_keymap('n', 'gr',    ':lua vim.lsp.buf.references()<CR>',      DEFAULT_KEYMAP)
      set_keymap('n', 'g0',    ':lua vim.lsp.buf.document_symbol()<CR>', DEFAULT_KEYMAP)

      vim.cmd [[ command Format :lua vim.lsp.buf.formatting() ]]
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
      }
    end
  }

  use {
    'rbong/vim-flog',
    cmd = { 'Flog', 'Flogsplit' },
  }

  use {
    'stephpy/vim-yaml',
    ft = { 'yaml' },
  }

  use {
    'tpope/vim-fugitive',
    config = fugitive_settings()
  }

  use {
    'z0mbix/vim-shfmt',
    ft = { 'sh', 'zsh' },
  }

end)

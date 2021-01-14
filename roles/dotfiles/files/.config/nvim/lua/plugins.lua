-- Shamelessly stolen from
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/plugins.lua
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

local open_win = function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  return vim.api.nvim_open_win(bufnr, true, {
    style = "minimal",
    relative = "win",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  })
end

return require('packer').startup({function()

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
    'junegunn/vim-easy-align',
    'justinmk/vim-dirvish',
    'mhinz/vim-startify',
    'nvim-lua/completion-nvim',
    'nvim-lua/lsp-status.nvim',
    'romainl/vim-cool',
    'tjdevries/lsp_extensions.nvim',
    'tjdevries/nlua.nvim',
    'tpope/vim-commentary',
    'tpope/vim-dispatch',
    'tpope/vim-eunuch',
    'tpope/vim-repeat',
    'tpope/vim-surround',
  }

  -- colors
  use {
    'christianchiarulli/nvcode-color-schemes.vim',
    'mhartington/oceanic-next',
  }

  use {
    'hardcoreplayers/oceanic-material',
    config = function()
      vim.g.oceanic_material_allow_bold = 1
      vim.g.oceanic_material_allow_italic = 1
      vim.g.oceanic_material_allow_underline = 1
      vim.g.oceanic_material_transparent_background = 1
      vim.o.background = "dark"
    end,
  }

  -- filetypes
  use {
    'Glench/Vim-Jinja2-Syntax',
    'PProvost/vim-ps1',
    'cespare/vim-toml',
    'chr4/nginx.vim',
    'euclidianAce/BetterLua.vim',
    'jvirtanen/vim-hcl',
    'martinda/Jenkinsfile-vim-syntax',
  }

  use {
    'kevinhwang91/nvim-hlslens',
  }

  use {
    'editorconfig/editorconfig-vim',
    config = function()
      vim.g.EditorConfig_exclude_patterns = { 'fugitive://.\\*' }
    end
  }

  use {
    'hkupty/nvimux',
    config = function()
      local nvimux = require('nvimux')

      nvimux.config.set_all{
        prefix = '<C-Space>',
        new_window = 'enew',
        new_tab = nil,
        new_window_buffer = 'single',
        quickterm_direction = 'botright',
        quickterm_orientation = 'vertical',
        quickterm_scope = 't',
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
    end,
    disable = true, -- I do not use this one often, but I would like to keep the configuration
  }

  use {
    'datwaft/bubbly.nvim', config = function()
      vim.g.bubbly_palette = {
        background = "#34343c",
        foreground = "#c5cdd9",
        black      = "#3e4249",
        red        = "#ec7279",
        green      = "#a0c980",
        yellow     = "#deb974",
        blue       = "#6cb6eb",
        purple     = "#d38aea",
        cyan       = "#5dbbc1",
        white      = "#c5cdd9",
        lightgrey  = "#57595e",
        darkgrey   = "#404247",
      }
      vim.g.bubbly_statusline = {
        'mode',
        'truncate',
        'path',
        'branch',
        'signify',
        'divisor',
        'filetype',
        {
          {
            data = '%l/%L',
          }
        },
      }
    end
  }

  use {
    'junegunn/goyo.vim',
    cmd = {'Goyo'},
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    },
    config = function()
      require('bigjazzsound.telescope')
      require('bigjazzsound.telescope.mappings')
    end
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
    'mhinz/vim-signify',
    config = [[ vim.g.signify_sign_change = '~' ]],
  }

  use {
    'neovim/nvim-lspconfig',
    -- This needs to be here so that require('nvim_lsp') can find the library
    -- TODO read https://github.com/wbthomason/packer.nvim/issues/4 for possible solutions
    config = [[ require('lsp_config') ]],
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
        },
      }
    end
  }

  use {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>ga',  ':Git add %:p<CR><CR>',            DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gs',  ':Gstatus<CR>',                    DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gc',  ':Gcommit -v -q<CR>',              DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gt',  ':Gcommit -v -q %:p<CR>',          DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gd',  ':Gdiff<CR>',                      DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>ge',  ':Gedit<CR>',                      DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gr',  ':Gread<CR>',                      DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gw',  ':Gwrite<CR><CR>',                 DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gl',  ':silent! Glog<CR>:bot copen<CR>', DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gp',  ':Ggrep<Space>',                   DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gm',  ':Gmove<Space>',                   DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gb',  ':Gblame!<CR>',                    DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>go',  ':Git checkout<Space>',            DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gps', ':Dispatch! Git push<CR>',         DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>gpl', ':Dispatch! Git pull<CR>',         DEFAULT_KEYMAP)
    end
  }

  end,

  config = {
    display = {
      working_sym = '.',
      error_sym = 'X',
      done_sym = 'C',
      removed_sym = '-',
      moved_sym = '->',
      header_sym = '-',
      show_all_info = false,
    }
  }
})

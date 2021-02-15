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

return require('packer').startup({function()

  use {
    'wbthomason/packer.nvim',
    opt = true,
  }

  -- Plugins without any special configuration
  use {
    'Yggdroot/indentLine',
    'christoomey/vim-tmux-navigator',
    'enricobacis/paste.vim',
    'junegunn/vim-easy-align',
    'justinmk/vim-dirvish',
    'nvim-lua/completion-nvim',
    'nvim-lua/lsp-status.nvim',
    'romainl/vim-cool',
    'tjdevries/lsp_extensions.nvim',
    'tjdevries/nlua.nvim',
    'tpope/vim-commentary',
    -- Waiting on this plugin to advance more. Specifically, using it with
    -- visual selections keeps the highlight after commenting.
    -- 'b3nj5m1n/kommentary',
    'tpope/vim-dispatch',
    'tpope/vim-eunuch',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
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
    'mhinz/vim-startify',
    config = function()
      if vim.fn.executable('figlet') then
        vim.g.startify_custom_header = vim.fn['startify#pad'](
          vim.fn.split(vim.fn.system[[ figlet -f 3D-ASCII "Neovim" ]], '\n')
        )
      end
    end,
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
    opt = true,
  }

  use {
    'datwaft/bubbly.nvim',
    config = function()
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
        'builtinlsp.diagnostic_count',
        'divisor',
        'builtinlsp.current_function',
        'filetype',
        {{ data = '%l/%L', }},
      }
      vim.g.bubbly_characters = {
        close = '',
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
      vim.api.nvim_set_keymap('n', '<leader>tT', '<CMD>TtoggleAll<CR>',    DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>tc', '<CMD>Tclear!<CR>',       DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>tF', '<CMD>TREPLSendFile<CR>', DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>tn', '<CMD>Tnew<CR>',          DEFAULT_KEYMAP)
      vim.api.nvim_set_keymap('n', '<leader>tt', '<CMD>Ttoggle<CR>',       DEFAULT_KEYMAP)
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
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        allow_prefix_unmatch = false,

        source = {
          path = true,
          buffer = true,
          calc = true,
          vsnip = true,
          nvim_lsp = true,
          nvim_lua = true,
          spell = true,
          snippets_nvim = true,
        },
      }
      vim.api.nvim_set_keymap('i', '<C-n>', 'compe#complete()',      { silent = true, expr = true, noremap = true })
      vim.api.nvim_set_keymap('i', '<CR>',  'compe#confirm("<CR>")', { silent = true, expr = true, noremap = true })
      vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")',  { silent = true, expr = true, noremap = true })
    end,
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
      open_cmd = string.format("%svnew [packer]", math.floor(vim.api.nvim_get_option("columns") / 2)),
      header_sym = '-',
    }
  }
})

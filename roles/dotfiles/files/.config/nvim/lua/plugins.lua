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

return require('packer').startup({function(use)

  use {
    'wbthomason/packer.nvim',
    opt = true,
  }

  -- Plugins without any special configuration
  use {
    'editorconfig/editorconfig-vim',
    'enricobacis/paste.vim',
    'junegunn/vim-easy-align',
    'romainl/vim-cool',
    'tjdevries/lsp_extensions.nvim',
    'tpope/vim-dispatch',
    'tpope/vim-eunuch',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
  }

  -- filetypes
  use {
    'Glench/Vim-Jinja2-Syntax',
    'PProvost/vim-ps1',
    'cespare/vim-toml',
    'chr4/nginx.vim',
    'jvirtanen/vim-hcl',
    'martinda/Jenkinsfile-vim-syntax',
    'saltstack/salt-vim',
  }

  use {
    'euclio/vim-markdown-composer',
    run = [[ cargo build --release ]],
    config = function()
      vim.g.markdown_composer_autostart = 0
      vim.g.markdown_composer_syntax_theme = "Atom One Dark"
    end,
  }

  use {
    'glepnir/indent-guides.nvim',
    config = function() require('bigjazzsound.indents') end,
  }

  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
      })
    end,
  }

  use {
    'mhinz/vim-startify',
    config = function() require('bigjazzsound.startify') end
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require('bigjazzsound.status') end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('bigjazzsound.telescope')
      require('bigjazzsound.telescope.mappings')
    end
  }

  use {
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup { winblend = 80 }
      vim.api.nvim_set_keymap('n', 's', [[<CMD>lua require('hop').hint_char2()<CR>]], {})
    end,
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('bigjazzsound.terminal') end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'glepnir/galaxyline.nvim',
    },
    config = function()
      require('gitsigns').setup{
        numhl = true,
        signs = {
          add          = { hl = 'DiffAdd',    text = '', numhl='GalaxyDiffAdd' },
          change       = { hl = 'DiffText',   text = '', numhl='GalaxyDiffModified' },
          delete       = { hl = 'DiffDelete', text = '', numhl='GalaxyDiffRemove' },
          topdelete    = { hl = 'DiffDelete', text = '', numhl='GalaxyDiffRemove' },
          changedelete = { hl = 'DiffText',   text = '', numhl='GalaxyDiffModified' },
        },
      }
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    config = function() require('bigjazzsound.lsp_config') end,
  }

  use {
    'norcalli/snippets.nvim',
    config = function() require('bigjazzsound.snippets') end,
  }

  use {
    'hrsh7th/nvim-compe',
    config = function() require('bigjazzsound.completion') end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }

      parser_config.hcl = {
        install_info = {
          url = "~/playground/tree-sitter-hcl",
          files = { "src/parser.c" }
        },
        filetype = "hcl",
        used_by = { "terraform", "hcl" },
      }
    end
  }

  use {
    'nvim-treesitter/playground',
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false -- Whether the query persists across vim sessions
        },
          query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = {"BufWrite", "CursorHold"},
        },
      }
    end
  }

  use {
    'onsails/lspkind-nvim',
    config = function() require('lspkind').init() end,
  }

  use {
    'TimUntersberger/neogit',
    config = function() require('bigjazzsound.git') end,
  }

  -- colors
  use {
    'christianchiarulli/nvcode-color-schemes.vim',
    'Th3Whit3Wolf/one-nvim',
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup{
        '!packer',
      }
    end,
  }

  end,

  config = {
    display = {
      open_cmd = string.format("%svnew [packer]", math.floor(vim.api.nvim_get_option("columns") / 2)),
      header_sym = '-',
    }
  }
})

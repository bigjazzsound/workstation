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
    'euclio/vim-markdown-composer',
    run = [[ cargo build --release ]],
  }

  use {
    'mhinz/vim-startify',
    config = function() require('bigjazzsound.startify') end
  }

  use {
    'editorconfig/editorconfig-vim',
    config = function()
      vim.g.EditorConfig_exclude_patterns = { 'fugitive://.\\*' }
    end
  }

  use {
    'hkupty/nvimux',
    config = function() require('bigjazzsound.nvimux') end,
    disable = true, -- I do not use this one often, but I would like to keep the configuration
    opt = true,
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require('bigjazzsound.status') end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      'ryanoasis/vim-devicons',
      opt = true
    },
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
    config = function() require('bigjazzsound.sneak') end
  }

  use {
    'kassio/neoterm',
    config = function() require('bigjazzsound.neoterm') end
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
    'hrsh7th/nvim-compe',
    config = function() require('bigjazzsound.completion') end
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
    config = function() require('bigjazzsound.fugitive') end
  }

  end,

  config = {
    display = {
      open_cmd = string.format("%svnew [packer]", math.floor(vim.api.nvim_get_option("columns") / 2)),
      header_sym = '-',
    }
  }
})

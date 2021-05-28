local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath "data")

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(string.format(
    "git clone %s %s",
    "https://github.com/wbthomason/packer.nvim",
    directory .. "/packer.nvim"
  ))

  print(out)
  print "Downloading packer.nvim..."

  vim.cmd "qall"

  return
end

return require "packer".startup {
  function(use)
    use {
      "wbthomason/packer.nvim",
      opt = true,
    }

    -- Plugins without any special configuration
    use {
      "editorconfig/editorconfig-vim",
      "enricobacis/paste.vim",
      "junegunn/vim-easy-align",
      "tpope/vim-eunuch",
      "tpope/vim-repeat",
      "tpope/vim-surround",
      "tpope/vim-unimpaired",
    }

    -- filetypes
    use {
      "Glench/Vim-Jinja2-Syntax",
      "PProvost/vim-ps1",
      "cespare/vim-toml",
      "chr4/nginx.vim",
      "jvirtanen/vim-hcl",
      "martinda/Jenkinsfile-vim-syntax",
      "saltstack/salt-vim",
    }

    use {
      "euclio/vim-markdown-composer",
      run = "cargo build --release",
      config = function()
        vim.g.markdown_composer_autostart = 0
        vim.g.markdown_composer_syntax_theme = "Atom One Dark"
      end,
    }

    use {
      "glepnir/indent-guides.nvim",
      config = function()
        require "bigjazzsound.indents"
        vim.api.nvim_set_keymap("n", "<leader>it", "<CMD>IndentGuidesToggle<CR>", DEFAULT_KEYMAP)
      end,
    }

    use {
      "b3nj5m1n/kommentary",
      config = function()
        require "kommentary.config".configure_language("default", {
          prefer_single_line_comments = true,
        })
      end,
    }

    use {
      "mhinz/vim-startify",
      config = function()
        require "bigjazzsound.startify"
      end,
    }

    use {
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require "bigjazzsound.status"
      end,
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require "bigjazzsound.telescope"
        require "bigjazzsound.telescope.mappings"
      end,
    }

    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      requires = { "nvim-telescope/telescope.nvim" },
    }

    use {
      "phaazon/hop.nvim",
      as = "hop",
      config = function()
        require "hop".setup { winblend = 80 }
        vim.api.nvim_set_keymap("n", "s", [[<CMD>lua require('hop').hint_char2()<CR>]], {})
      end,
    }

    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require "gitsigns".setup {
          numhl = true,
          use_internal_diff = false,
        }
      end,
    }

    use "ckipp01/stylua-nvim"

    use {
      { "neovim/nvim-lspconfig" },
      { "lspcontainers/lspcontainers.nvim" },
      { "glepnir/lspsaga.nvim", config = function()
        require "bigjazzsound.lsp_config"
      end },
    }

    use {
      "norcalli/snippets.nvim",
      config = function()
        require "bigjazzsound.snippets"
      end,
    }

    use {
      "hrsh7th/nvim-compe",
      config = function()
        require "bigjazzsound.completion"
      end,
    }

    use {
      { "nvim-treesitter/nvim-treesitter" },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        run = ":TSUpdate",
        config = function()
          local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
          require "nvim-treesitter.configs".setup {
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
            textobjects = {
              select = {
                enable = true,
                keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                },
              },
              swap = {
                enable = true,
                swap_next = {
                  ["]p"] = "@parameter.inner",
                },
                swap_previous = {
                  ["[p"] = "@parameter.inner",
                },
              },
              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]m"] = "@function.outer",
                  ["]]"] = "@class.outer",
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer",
                },
                goto_previous_end = {
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer",
                },
              },
              lsp_interop = {
                enable = true,
                peek_definition_code = {
                  ["df"] = "@function.outer",
                  ["dF"] = "@class.outer",
                },
              },
            },
          }

          parser_config.hcl = {
            install_info = {
              url = "~/playground/tree-sitter-hcl",
              files = { "src/parser.c" },
            },
            filetype = "hcl",
            used_by = { "terraform", "hcl" },
          }
        end,
      },
    }

    use {
      "nvim-treesitter/playground",
      config = function()
        require "nvim-treesitter.configs".setup {
          playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false,
          },
          query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { "BufWrite", "CursorHold" },
          },
        }
      end,
    }

    use {
      "onsails/lspkind-nvim",
      config = function()
        require "lspkind".init()
      end,
    }

    use {
      "TimUntersberger/neogit",
      config = function()
        require "bigjazzsound.git"
      end,
    }

    -- colors
    use {
      "christianchiarulli/nvcode-color-schemes.vim",
      "Th3Whit3Wolf/one-nvim",
      "folke/tokyonight.nvim",
    }

    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup {
          "!packer",
        }
      end,
    }

    use {
      "numToStr/Navigator.nvim",
      config = function()
        require "Navigator".setup()
        vim.api.nvim_set_keymap("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", DEFAULT_KEYMAP)
        vim.api.nvim_set_keymap("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", DEFAULT_KEYMAP)
        vim.api.nvim_set_keymap("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", DEFAULT_KEYMAP)
        vim.api.nvim_set_keymap("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", DEFAULT_KEYMAP)
      end,
    }

    use {
      "numtostr/FTerm.nvim",
      config = function()
        require "bigjazzsound.terminal"
      end,
    }

    use {
      "kevinhwang91/nvim-hlslens",
      config = function()
        vim.api.nvim_set_keymap(
          "n",
          [[<CMD>execute('normal! ' . v:count1 . 'n')<CR>]],
          [[<CMD>lua require('hlslens').start()<CR>]],
          DEFAULT_KEYMAP
        )
        vim.api.nvim_set_keymap(
          "n",
          [[<CMD>execute('normal! ' . v:count1 . 'N')<CR>]],
          [[<CMD>lua require('hlslens').start()<CR>]],
          DEFAULT_KEYMAP
        )
        vim.api.nvim_set_keymap("n", "*", [[*<CMD>lua require('hlslens').start()<CR>]], DEFAULT_KEYMAP)
        vim.api.nvim_set_keymap("n", "#", [[#<CMD>lua require('hlslens').start()<CR>]], DEFAULT_KEYMAP)
        vim.api.nvim_set_keymap("n", "g*", [[g*<CMD>lua require('hlslens').start()<CR>]], DEFAULT_KEYMAP)
        vim.api.nvim_set_keymap("n", "g#", [[g#<CMD>lua require('hlslens').start()<CR>]], DEFAULT_KEYMAP)

        require "hlslens".setup {
          calm_down = true,
        }
      end,
    }

    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          window = {
            backdrop = 1
          }
        }
      end
    }

    -- use 'hkupty/daedalus.nvim'
    use "~/playground/bigjazzsound/daedalus.nvim"
    use "folke/lua-dev.nvim"

  end,

  config = {
    display = {
      open_cmd = string.format("%svnew [packer]", math.floor(vim.api.nvim_get_option "columns" / 2)),
      header_sym = "-",
    },
  },
}

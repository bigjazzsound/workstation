require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 2,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  allow_prefix_unmatch = false,

  source = {
    buffer = true,
    calc = false,
    emoji = true,
    luasnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    nvim_treesitter = false,
    omni = false,
    path = true,
    snippets_nvim = false,
    spell = false,
    tags = false,
    ultisnips = false,
    vim_lsc = false,
    vim_lsp = false,
    vsnip = false,
  },
}

local opts = { silent = true, expr = true, noremap = true }

vim.api.nvim_set_keymap("i", "<C-n>", "compe#complete()", opts)
vim.api.nvim_set_keymap("i", "<CR>", 'compe#confirm("<CR>")', opts)
vim.api.nvim_set_keymap("i", "<C-e>", 'compe#close("<C-e>")', opts)
vim.api.nvim_set_keymap("i", "<C-f>", 'compe#scroll({ "delta": +4 })', opts)
vim.api.nvim_set_keymap("i", "<C-d>", 'compe#scroll({ "delta": -4 })', opts)

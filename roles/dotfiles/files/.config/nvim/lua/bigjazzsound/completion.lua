require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
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
local opts = { silent = true, expr = true, noremap = true }

vim.api.nvim_set_keymap("i", "<C-n>", "compe#complete()", opts)
vim.api.nvim_set_keymap("i", "<CR>", 'compe#confirm("<CR>")', opts)
vim.api.nvim_set_keymap("i", "<C-e>", 'compe#close("<C-e>")', opts)
vim.api.nvim_set_keymap("i", "<C-f>", 'compe#scroll({ "delta": +4 })', opts)
vim.api.nvim_set_keymap("i", "<C-d>", 'compe#scroll({ "delta": -4 })', opts)

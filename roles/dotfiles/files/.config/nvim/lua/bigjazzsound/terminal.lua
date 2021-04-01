require('toggleterm').setup{
  size = vim.api.nvim_get_option("columns") / 2,
  open_mapping = '<leader>tt',
  shade_filetypes = {},
  shade_terminals = false,
  start_in_insert = true,
  persist_size = false,
  direction = 'vertical',
}

vim.cmd [[ au TermOpen * setlocal nonumber norelativenumber | :wincmd = ]]

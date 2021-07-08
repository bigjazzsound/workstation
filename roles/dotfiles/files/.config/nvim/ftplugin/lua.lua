vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.fileformat = "unix"

vim.api.nvim_buf_set_keymap(
  vim.api.nvim_get_current_buf(),
  "n",
  "<leader>lf",
  [[<CMD>lua require("stylua-nvim").format_file()<CR>]],
  { noremap = true, silent = true }
)

vim.cmd [[au BufWritePre <buffer> lua require("stylua-nvim").format_file()]]

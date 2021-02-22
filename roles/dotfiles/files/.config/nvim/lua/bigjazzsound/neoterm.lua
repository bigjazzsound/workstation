vim.g.neoterm_autoinsert = 1
vim.g.neoterm_clear_cmd = { "clear", "" }
vim.g.neoterm_default_mod = "vertical"
vim.api.nvim_set_keymap('n', '<leader>tT', '<CMD>TtoggleAll<CR>',    DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>tc', '<CMD>Tclear!<CR>',       DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>tF', '<CMD>TREPLSendFile<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>tn', '<CMD>Tnew<CR>',          DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('n', '<leader>tt', '<CMD>Ttoggle<CR>',       DEFAULT_KEYMAP)

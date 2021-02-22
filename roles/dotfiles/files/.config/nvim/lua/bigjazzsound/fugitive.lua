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
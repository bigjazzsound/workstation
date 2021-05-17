require "neogit".setup()

vim.api.nvim_set_keymap("n", "<leader>gs", '<CMD>lua require("neogit").status.create("vsplit")<CR>', DEFAULT_KEYMAP)

vim.cmd [[highlight NeogitDiffAddHighlight guifg=#98c379 guibg=#3e4452]]
vim.cmd [[highlight NeogitDiffDeleteHighlight guifg=#e06c75 guibg=#3e4452]]
vim.cmd [[highlight NeogitDiffContextHighlight guibg=#282C34]]

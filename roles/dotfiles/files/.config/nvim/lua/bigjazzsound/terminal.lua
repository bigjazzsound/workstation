require("FTerm").setup {
    dimensions  = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.5
    },
    border = 'double'
}

vim.api.nvim_set_keymap('n', '<M-t>', '<CMD>lua require("FTerm").toggle()<CR>', DEFAULT_KEYMAP)
vim.api.nvim_set_keymap('t', '<M-t>', '<CMD>lua require("FTerm").toggle()<CR>', DEFAULT_KEYMAP)

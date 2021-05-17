require "lualine".setup {
  options = {
    theme = "tokyonight",
    section_separators = { "", "" },
    component_separators = { "", "" },
    disabled_filetypes = {},
    icons_enabled = true,
  },
  sections = {
    lualine_a = {
      { "branch", icon = "" },
    },
    lualine_b = {
      { "filename", file_status = true },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_lsp" } },
    },
    lualine_x = {
      "encoding",
      "fileformat",
      { "filetype", colored = false },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
}

local lsp_progress = function()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then return end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

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
    lualine_y = {{lsp_progress}},
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

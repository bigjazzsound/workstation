local actions = require('telescope.actions')
local previewers = require('telescope.previewers')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["jk"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["jk"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- ["<tab>"] = actions.add_selection,
        ["<tab>"] = actions.toggle_selection,

      },
    },
    -- Rounded corners don't look right with my font
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    prompt_position = "top",
    sorting_strategy = "ascending",
    width = 0.95,
    winblend = 5,
    preview_cutoff = 120,
    -- These previewers are experimental but they are FAST
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
  }
}

local M = {}
local preview_width = 0.55

-- Does not seem to work with the show_all_buffers option
function M.show_all_buffers()
  require('telescope.builtin').buffers{
    show_all_buffers = true,
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.find_dotfiles()
  require('telescope.builtin').git_files {
    cwd = "~/playground/workstation",
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.grep_dotfiles()
  require('telescope.builtin').live_grep {
    cwd = "~/playground/workstation",
    vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden' },
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
    layout_config = {
      preview_width = 0.60,
    },
  }
end

function M.fd()
  require('telescope.builtin').fd{
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.oldfiles()
  require('telescope.builtin').oldfiles {
    shorten_path = true,
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.builtin()
  require('telescope.builtin').builtin {
    previewer = false
  }
end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      -- print("Executing: add ", vim.inspect(M[k]))
      return M[k]
    else
      -- print("Executing: require ", require('telescope.builtin')[k])
      return require('telescope.builtin')[k]
    end
  end
})

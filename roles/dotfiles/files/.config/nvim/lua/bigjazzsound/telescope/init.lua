local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local sorters = require "telescope.sorters"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"

local my_actions = {
  ["jk"] = actions.close,
  ["<C-j>"] = actions.move_selection_next,
  ["<C-k>"] = actions.move_selection_previous,
  ["<C-p>"] = actions.add_selection,
  ["<tab>"] = actions.toggle_selection,
  ["<C-q>"] = actions.send_selected_to_qflist,
}

require "telescope".setup {
  defaults = {
    mappings = {
      i = my_actions,
      n = my_actions,
    },
    -- Rounded corners don't look right with my font
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    prompt_position = "top",
    sorting_strategy = "ascending",
    width = 0.95,
    winblend = 5,
    preview_cutoff = 120,
  },
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

require "telescope".load_extension "fzf"

local M = {}
local preview_width = 0.55

function M.terraform_resources()
  -- If there is a justfile in the current directory, then set just as the finder
  local ft = {}
  local files = require "plenary.scandir".scan_dir(".", { hidden = false, depth = 1 })
  if vim.tbl_contains(vim.tbl_map(vim.fn.tolower, files), "justfile") then
    ft = {
      finder = { "just", "list" },
      previewer = { "just", "show" },
    }
  else
    ft = {
      finder = { "terraform", "state", "-no-color", "list" },
      previewer = { "terraform", "state", "-no-color", "show" },
    }
  end

  pickers.new {
    results_title = "Resources",
    finder = finders.new_oneshot_job(ft.finder),
    sorter = sorters.get_fuzzy_file(),
    -- TODO - this is really slow because `terraform show` is slow. Possible alternatives are
    -- making a custom action that will open the content of `terraform show` in a new buffer on <CR>
    previewer = previewers.new_termopen_previewer {
      get_command = function(entry)
        return vim.fn.extend(ft.previewer, { entry.value })
      end,
    },
  }:find()
end

-- Does not seem to work with the show_all_buffers option
function M.show_all_buffers()
  require "telescope.builtin".buffers {
    show_all_buffers = true,
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.find_dotfiles()
  require "telescope.builtin".git_files {
    cwd = "~/playground/workstation",
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.grep_dotfiles()
  require "telescope.builtin".live_grep {
    cwd = "~/playground/workstation",
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.help_tags()
  require "telescope.builtin".help_tags {
    show_version = true,
    layout_config = {
      preview_width = 0.60,
    },
  }
end

function M.find_project_files()
  local opts = {
    layout_config = {
      preview_width = preview_width,
    },
  }
  local ok = pcall(require "telescope.builtin".git_files, opts)
  if not ok then
    require "telescope.builtin".find_files(opts)
  end
end

function M.find_projects()
  require "telescope.builtin".file_browser {
    cwd = "~/playground",
  }
end

function M.oldfiles()
  require "telescope.builtin".oldfiles {
    shorten_path = true,
    layout_config = {
      preview_width = preview_width,
    },
  }
end

function M.builtin()
  require "telescope.builtin".builtin {
    previewer = false,
  }
end

function M.file_browser()
  require "telescope.builtin".file_browser {}
end

return setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      -- print("Executing: add ", vim.inspect(M[k]))
      return M[k]
    else
      -- print("Executing: require ", require('telescope.builtin')[k])
      return require "telescope.builtin"[k]
    end
  end,
})
